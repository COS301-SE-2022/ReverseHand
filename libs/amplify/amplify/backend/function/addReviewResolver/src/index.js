const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
   try{

    //creating a data to add to the review
    const date = new Date();
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = date.getFullYear();
    const currentDate = mm + '-' + dd + '-' + yyyy;
    
    //get the data in the database
    let params = {
        TableName: UserTable,
        Key: {
            user_id: event.arguments.user_id,
        }
    }

    let data = await docClient.get(params).promise();

    //Update values in the database.
    let args = [];
    let expressionAttributeNames = [];

    event.arguments.reviews.date_created = currentDate;

    let inputReview = [];
    inputReview.push(event.arguments.reviews);
    let mergedList = [...data['Item']['reviews'],...inputReview];

    //get the sum of the ratings/
    let sum = 0;
    mergedList.forEach(review =>{
        sum += parseInt(review['rating']);
    })
    //convert the numeric sum to a string
    sum = sum.toString();

    if(event.arguments.reviews !== undefined){
        args.push('#reviews = :reviews');
        expressionAttributeNames['#reviews'] = 'reviews';
    }

    //Not using an if for "sum" attribute as its only calculated in resolver and returned 
        args.push('#sum = :sum');
        expressionAttributeNames['#sum'] = 'sum';

    let updateExpression = 'set ';

    for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
    let expressionAttributeValues = {};

    expressionAttributeValues[':reviews'] = mergedList;
    expressionAttributeValues[':sum'] = sum;

    params = {
        TableName: UserTable,
        Key: {
            user_id: event.arguments.user_id,
        },
        UpdateExpression: updateExpression,
        ExpressionAttributeValues: expressionAttributeValues,
        ExpressionAttributeNames: expressionAttributeNames,
    };

    await docClient.update(params).promise();

    params = {
        TableName: UserTable,
        Key: {
            user_id: event.arguments.user_id,
        }
    };

    data = await docClient.get(params).promise();


    return data['Item']['reviews'];

   }catch (error){

    console.log(error);
   }
};

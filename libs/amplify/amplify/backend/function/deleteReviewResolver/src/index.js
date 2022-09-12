const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   
    try {
        
        //get the user details    
        let params = {
            TableName: UserTable,
            Key:{
                user_id: event.arguments.user_id,
            }
        };

        let data = await docClient.get(params).promise();

        let reviews = data["Item"]["reviews"];
        let newReviews = [];
        let newRatingSum = 0;

        reviews.forEach(review => {
            if((review["id"].localeCompare(event.arguments.id)) != 0)//id is the review id.
            {
                newReviews.push(review);
                newRatingSum += parseInt(review['rating']);//getting the new sum of ratings
            }
        });

        newRatingSum = newRatingSum.toString();//converting the int to a string

        //updating the users reviews with the deleted one

        let args = [];
        let expressionAttributeNames = [];

        //arguments for list of reviews
        args.push('#reviews = :reviews');
        expressionAttributeNames['#reviews'] = 'reviews';

        //arguments for the new rating sum
        args.push('#sum = :sum');
        expressionAttributeNames['#sum'] = 'sum';

        let updateExpression = 'set ';

         for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
        let expressionAttributeValues = {};

        expressionAttributeValues[':reviews'] = newReviews;
        expressionAttributeValues[':sum'] = newRatingSum;

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

        //get the updated reviews from the database and return them
        params = {
            TableName: UserTable,
            Key: {
                user_id: event.arguments.user_id,
            }
        };
    
        data = await docClient.get(params).promise();
    
    
        return data['Item']['reviews'];

    } catch (error) {
        console.log(error)
    }
};

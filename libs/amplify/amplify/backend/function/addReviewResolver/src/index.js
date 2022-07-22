const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
   try{
    
    let args = [];
    let expressionAttributeNames = [];


    if(event.arguments.reviews !== undefined){
        args.push('#reviews = :reviews');
        expressionAttributeNames['#reviews'] = 'reviews';
    }

    let updateExpression = 'set ';

    for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
    let expressionAttributeValues = {};

    expressionAttributeValues[':reviews'] = event.arguments.reviews;

    let params = {
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

    const data = await docClient.get(params).promise();

    return data['Item'];

   }catch (error){

    console.log(error);
   }
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
   try{
    let item = {
        TableName: UserTable,
        Item: {
            user_id: event.arguments.user_id,
            reviews: {
                review: event.arguments.review,
                reviewer: event.arguments.reviewer
            }
        }
    };

    await docClient.put(item).promise();

    return item.Item["reviews"];//return the newly created review
   }catch (error){

    console.log(error);
   }
};

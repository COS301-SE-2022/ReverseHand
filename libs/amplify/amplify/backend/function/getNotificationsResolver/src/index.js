const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// gets all notificatiosn for a specfic user
// input paramter is user id
exports.handler = async (event) => {
    let params = {
        TableName: UserTable, 
        KeyConditionExpression: "user_id = :u",
        ExpressionAttributeValues: {
            ":u": event.arguments.user_id,
        }
    };
    const data = await docClient.query(params).promise();
    let item = data["Items"][0];
    
    item.id = item.user_id;
    delete item.user_id;
    
    return item;
};

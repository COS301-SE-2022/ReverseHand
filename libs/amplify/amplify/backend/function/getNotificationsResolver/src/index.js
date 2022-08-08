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
        Key: {
            user_id: event.arguments.user_id
        }
    };
    const data = await docClient.get(params).promise();
    const item = data.Item.notifications;
    
    return item;
};

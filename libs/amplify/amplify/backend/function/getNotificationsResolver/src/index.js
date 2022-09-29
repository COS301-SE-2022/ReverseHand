const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// gets all notificatiosn for a specfic user
// input paramter is user id
exports.handler = async (event) => {
    const params = {
        TableName: ReverseHandTable, 
        KeyConditionExpression: "part_key = :id",
        ExpressionAttributeValues: {
            ":id": "notification#" + event.arguments.user_id,
        }
    };

    const notifications = await docClient.query(params)
    .promise().then(data => data.Items);
    return notifications;
};

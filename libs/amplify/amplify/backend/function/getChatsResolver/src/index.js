const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

// get all chats for a specific user

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        KeyConditionExpression: 'part_key = :chats_id',
        ExpressionAttributeValues: {
            ':chats_id': 'chats#' + event.arguments.user_id
        }
    }).promise();

    return response.Items.map((el) => {
        el['id'] = el['sort_key'];
        return el;
    });
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

// resolver which returns all messahes for a chat

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        KeyConditionExpression: 'part_key = :chat_id',
        ExpressionAttributeValues: {
            'chat_id': 'chat#' + event.arguments.chat_id
        }
    }).promise();

    return response.Items.map(el => el['id'] = el['sort_key']);
};

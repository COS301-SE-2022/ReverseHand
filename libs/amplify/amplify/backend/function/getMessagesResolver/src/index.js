const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchiveReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

// resolver which returns all messahes for a chat

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        KeyConditionExpression: 'part_key = :chat_id',
        ExpressionAttributeValues: {
            ':chat_id': event.arguments.chat_id
        }
    }).promise();

    if (response.Items.length == 0)
        response = await docClient.query({
            TableName: ArchiveReverseHandTable,
            KeyConditionExpression: 'part_key = :chat_id',
            ExpressionAttributeValues: {
                ':chat_id': event.arguments.chat_id
            }
        }).promise()

    return response.Items.map((el) =>{
        el['chat_id'] = el['part_key'];
        el['id'] = el['sort_key'];
        return el;
    });
};

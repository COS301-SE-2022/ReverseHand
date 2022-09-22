// resolver that sends a message between two users
// requires both a tradesman id, consumer id, msg, sender
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    const date = new Date();
    const timestamp = date.getTime();
    const msgId = date.toISOString();

    await docClient.put({
        TableName: ReverseHandTable,
        Item: {
            part_key: event.arguments.chat_id,
            sort_key: msgId,
            timestamp: timestamp,
            msg: event.arguments.msg,
            sender: event.arguments.sender,
        }
    }).promise();

    return {
        id: msgId,
        chat_id: event.arguments.chat_id,
        timestamp: timestamp,
        msg: event.arguments.msg,
        sender: event.arguments.sender,
    };
};

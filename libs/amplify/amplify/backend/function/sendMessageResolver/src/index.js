// resolver that sends a message between two users
// requires both a tradesman id, consumer id, msg, sender
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    const timestamp = (new Date()).getTime();
    const msgId = AWS.util.uuid.v4()

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
        consumer_id: event.arguments.consumer_id,
        tradesman_id: event.arguments.tradesman_id,
        timestamp: timestamp,
        msg: event.arguments.msg,
        sender: event.arguments.sender,
    };
};

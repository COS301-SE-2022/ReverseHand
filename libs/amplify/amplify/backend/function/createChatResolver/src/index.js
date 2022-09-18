// resolver that creates the chat between two users
// requires both a tradesman and consumer id

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    const timestamp = (new Date()).getTime();
    const chatId = AWS.util.uuid.v4()

    await docClient.batchWrite({
      RequestItems: {
        ReverseHand: [
          // for consumer
          {
            PutRequest: {
              Item: {
                part_key: "chats#" + event.arguments.c_id,
                sort_key: "chat#" + chatId,
                timestamp: timestamp,
                consumer_name: event.arguments.c_name,
                tradesman_name: event.arguments.t_name,
              }
            }
          },
          // for tradesman
          {
            PutRequest: {
              Item: {
                part_key: "chats#" + event.arguments.t_id,
                sort_key: "chat#" + chatId,
                timestamp: timestamp,
                consumer_name: event.arguments.c_name,
                tradesman_name: event.arguments.t_name,
              }
            }
          }
        ]
      }
    }).promise();

    return {
      id: chatId,
      timestamp: timestamp,
      consumer_name: event.arguments.c_name,
      tradesman_name: event.arguments.t_name,
    };
};

// resolver that creates the chat between two users
// requires both a tradesman and consumer id

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    const timestamp = (new Date()).getTime();
    const chatId = event.arguments.ad_id

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
                other_user_id: event.arguments.t_id,
                consumer_name: event.arguments.c_name,
                tradesman_name: event.arguments.t_name,
                negativeMessages: 0,
                positiveMessages: 0,
                neutralMessages: 0,
                positive: 0,
                negative: 0,
                sentiment: 'sentiments',
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
                other_user_id: event.arguments.c_id,
                consumer_name: event.arguments.c_name,
                tradesman_name: event.arguments.t_name,
                negativeMessages: 0,
                positiveMessages: 0,
                neutralMessages: 0,
                positive: 0,
                negative: 0,
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

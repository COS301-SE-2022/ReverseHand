// resolver that creates the chat between two users
// requires both a tradesman and consumer id

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let item = {
        TableName: ReverseHandTable,
        Item: {
          part_key: event.arguments.c_id,
          sort_key: event.arguments.t_id,
          messages: []
        },
    };

    await docClient.put(item).promise();

    return item.Item;
};

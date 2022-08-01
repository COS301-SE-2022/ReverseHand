// resolver that sends a message between two users
// requires both a tradesman id, consumer id, msg, sender
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let expressionAttributeValues = {
        ":msg": [{
            msg: event.arguments.msg,
            timestamp: (new Date()).getTime(),
            sender: event.arguments.sender,
            name: event.arguments.name,
        }]
    };

    let params = {
        TableName: ReverseHandTable,
        Key: {
          part_key: event.arguments.c_id,
          sort_key: event.arguments.t_id,
        },
        UpdateExpression: "set messages = list_append(messages, :msg)",
        ExpressionAttributeValues: expressionAttributeValues,
    };

    await docClient.update(params).promise();

    expressionAttributeValues[":msg"][0]["consumer_id"] = event.arguments.c_id;
    expressionAttributeValues[":msg"][0]["tradesman_id"] = event.arguments.t_id;

    return expressionAttributeValues[":msg"][0];
};

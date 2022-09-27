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

    let updateExpression;
    let expressionAttributeNames;
    let expressionAttributeValues;
    if (event.arguments.sentiment < 0) {
        updateExpression = 'SET #messages = #messages + :one, #kind = #kind + :val';
        expressionAttributeNames = {
            '#messages': 'negative_messages',
            '#kind': 'negative',
        };
        expressionAttributeValues = {
            ':val': event.arguments.sentiment,
            ':one': 1,
        };
    } else if (event.arguments.sentiment > 0) {
        updateExpression = 'SET #messages = #messages + :one, #kind = #kind + :val';
        expressionAttributeNames = {
            '#messages': 'positive_messages',
            '#kind': 'positive',
        };
        expressionAttributeValues = {
            ':val': event.arguments.sentiment,
            ':one': 1,
        };
    } else {
        updateExpression = 'SET #messages = #messages + :one';
        expressionAttributeNames = {
            '#messages': 'neutral_messages',
        };
        expressionAttributeValues = {
            ':one': 1,
        };
    }

    await docClient.transactWrite({
        TransactItems: [
            {
                Put: {
                    TableName: ReverseHandTable,
                    Item: {
                        part_key: event.arguments.chat_id,
                        sort_key: msgId,
                        timestamp: timestamp,
                        msg: event.arguments.msg,
                        sender: event.arguments.sender,
                        sentiment: event.arguments.sentiment,
                    }
                }
            },
            // overall for the app
            {
                Update: {
                    TableName: ReverseHandTable,
                    Key: {
                        part_key: 'sentiment',
                        sort_key: 'sentiment',
                    },
                    UpdateExpression: updateExpression,
                    ExpressionAttributeValues: expressionAttributeValues,
                    ExpressionAttributeNames: expressionAttributeNames,
                },
            },
            {
                // for each individual person
                Update: {
                    TableName: ReverseHandTable,
                    Key: {
                        part_key: 'chats#' + event.arguments.sender_id,
                        sort_key: event.arguments.chat_id,
                    },
                    ExpressionAttributeNames: expressionAttributeNames,
                    UpdateExpression: updateExpression,
                    ExpressionAttributeValues: expressionAttributeValues,
                },
            },
            {
                Update: {
                    TableName: ReverseHandTable,
                    Key: {
                        part_key: 'chats#' + event.arguments.reciever_id,
                        sort_key: event.arguments.chat_id,
                    },
                    ExpressionAttributeNames: expressionAttributeNames,
                    UpdateExpression: updateExpression,
                    ExpressionAttributeValues: expressionAttributeValues,
                }
            }
        ]
    }).promise();

    return {
        id: msgId,
        chat_id: event.arguments.chat_id,
        timestamp: timestamp,
        msg: event.arguments.msg,
        sender: event.arguments.sender,
    };
};

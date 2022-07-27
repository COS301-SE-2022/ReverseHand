const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// takes the suer id and the position of the item from the list to be removed
exports.handler = async (event) => {
    let params = {
        TableName: UserTable,
        Key: {
          user_id: event.arguments.user_id,
        },
        UpdateExpression: `remove domains[:pos]`,
        ExpressionAttributeValues: {
          ":pos": event.arguments.domain_pos
        },
    };

    await docClient.update(params).promise();

    return event.arguments.domain_pos; // returning position of deleted item
};

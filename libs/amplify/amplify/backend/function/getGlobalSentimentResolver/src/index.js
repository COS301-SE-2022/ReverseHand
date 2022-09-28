const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// gets the global chat sentiment for the resolver
exports.handler = async (event) => {
    let data = await docClient.get({
        TableName: ReverseHandTable,
        Key: {
            part_key: 'sentiment',
            sort_key: 'sentiment',
        }
    }).promise();

    return data.Item;
};

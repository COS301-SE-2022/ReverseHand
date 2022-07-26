// resolver that gets all messages for a consumer
// requires a consumer id

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        KeyConditionExpression: "part_key = :c",
        ExpressionAttributeValues: {
            ":c": event.arguments.c_id, // should be a consumers id
        }
    };

    const data = await docClient.query(params).promise();
    console.log(null);

    return null;
};

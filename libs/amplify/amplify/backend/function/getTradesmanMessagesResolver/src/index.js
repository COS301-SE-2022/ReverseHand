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
        IndexName: "swap_keys",
        KeyConditionExpression: "sort_key = :t",
        ExpressionAttributeValues: {
            ":t": event.arguments.t_id, // should be a consumers id
        }
    };

    const data = await docClient.query(params).promise();
    
    for (let d of data.Items) {
        d['consumer_id'] = d['part_key'];
        d['tradesman_id'] = d['sort_key'];
    }

    return data.Items;
};

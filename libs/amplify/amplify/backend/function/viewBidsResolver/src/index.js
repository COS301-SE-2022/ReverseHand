const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, context) => {
    console.log(event);
    console.log(context);

    let params = {
        TableName: ReverseHandTable,
        IndexName: "part_id-user_id-index",
        KeyConditionExpression: "user_id = c#001",
    };

    try {
        const data = await docClient.query(params).promise();

        return {
            id: err
        };
    } catch {
        return {
            id: err
        };
    }

};

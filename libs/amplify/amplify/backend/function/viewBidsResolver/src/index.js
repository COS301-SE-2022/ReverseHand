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
        KeyConditionExpression: "user_id = c#001",
    };

    try {
        const data = await docClient.scan(params).promise();

        return {
            id: "Hi"
        };
    } catch(e) {
        return {
            id: e
        };
    }

};

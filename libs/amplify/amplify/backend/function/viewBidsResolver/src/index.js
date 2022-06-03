const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, context) => {
    // console.log(event);
    // console.log(context);

    let params = {
        TableName: ReverseHandTable,
        KeyConditionExpression: "user_id = :u and sort_key = :s",
        ExpressionAttributeValues: {
            ":u": event.arguments.user_id,
            ":s": event.arguments.ad_id
        }
    };

    try {
        const data = await docClient.query(params).promise();
        console.log(data);

        return {
            id: "Hi"
        };
    } catch(e) {
        return {
            id: e
        };
    }

};

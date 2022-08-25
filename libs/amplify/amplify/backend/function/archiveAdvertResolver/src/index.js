const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// archive an advert without a winning bid
exports.handler = async (event) => {
    const date = new Date();
    const currentDate = date.getTime();

    let item = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
        UpdateExpression: 'set advert_details.date_closed = :ab',
        ExpressionAttributeValues: {
            ':date': currentDate,
        },
    };

    await docClient.update(item).promise();

    item = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
    };

    let data = await docClient.update(item).promise();
    data['advert_details']['id'] = event.rguments.ad_id;

    return data['advert_details'];
};

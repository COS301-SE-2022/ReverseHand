const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// archive an advert without a winning bid
exports.handler = async (event) => {
    const date = new Date();
    const currentDate = date.getTime();

    // deleting advert
    let item = {
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_OLD',
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
    };

    let resp = await docClient.delete(item).promise().then((resp) => resp.Attributes);

    resp['advert_details']['date_closed'] = currentDate;

    item = {
        TableName: ArchivedReverseHandTable,
        Item: resp,
    };

    // deleting bids
    

    await docClient.put(item).promise();
    resp['advert_details']['id'] = event.arguments.ad_id;

    return resp['advert_details'];
};

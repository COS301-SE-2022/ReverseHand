const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const TradesmanViewIndex = process.env.TRADESMAN;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// get all the adverts which a tradesman has bid on
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        IndexName: TradesmanViewIndex,
        KeyConditionExpression: 'tradesman_id = :id',
        ExpressionAttributeValues: {
            ':id': event.arguments.tradesman_id
        }
    }).promise();

    let items = {};
    let added = {};
    items[ReverseHandTable] = {};
    items[ReverseHandTable]['Keys'] = [];
    
    // to ensure that there are not duplicates
    for (let bid of response.Items) {
        if (added[bid.part_key] == undefined) {
            added[bid.part_key] = true;
            items[ReverseHandTable]['Keys'].push({
                part_key: bid.part_key,
                sort_key: bid.part_key
            });
        }
    }
    
    let adverts = await docClient.batchGet({
        RequestItems: items
    }).promise();

    return adverts.Responses[ReverseHandTable].map((el) => {
        el.advert_details['id'] = el.part_key;
        el.advert_details['customer_id'] = el.customer_id;
        return el.advert_details;
    });
};

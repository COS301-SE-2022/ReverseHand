const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const TradesmanViewIndex = process.env.TRADESMAN;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// get all the adverts which a tradesman has bid on
exports.handler = async (event) => {
    // deciding where to get adverts from
    let table;
    if (event.arguments.archived)
        table = ArchivedReverseHandTable;
    else
        table = ReverseHandTable;

    let response = await docClient.query({
        TableName: table,
        IndexName: TradesmanViewIndex,
        KeyConditionExpression: 'tradesman_id = :id',
        ExpressionAttributeValues: {
            ':id': event.arguments.tradesman_id
        }
    }).promise();

    if (response.Items.length == 0)
        return [];

    let items = {};
    let added = {};
    items[table] = {};
    items[table]['Keys'] = [];
    
    // to ensure that there are not duplicates
    for (let bid of response.Items) {
        if (added[bid.part_key] == undefined) {
            added[bid.part_key] = true;
            items[table]['Keys'].push({
                part_key: bid.part_key,
                sort_key: bid.part_key
            });
        }
    }
    
    let adverts = await docClient.batchGet({
        RequestItems: items
    }).promise();

    return adverts.Responses[table].map((el) => {
        el.advert_details['id'] = el.part_key;
        el.advert_details['customer_id'] = el.customer_id;
        return el.advert_details;
    });
};

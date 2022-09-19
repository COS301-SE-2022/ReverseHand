const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// archive an advert without a winning bid
exports.handler = async (event) => {
    // archiving bids

    // getting bids
    let params = {
        TableName: ReverseHandTable,
        KeyConditionExpression: "part_key = :p and begins_with(sort_key, :b)", // filtering by bids
        ExpressionAttributeValues: {
            ":p": event.arguments.ad_id,
            ":b": "b#",
        }
    };
    let data = await docClient.query(params).promise();
    let items = data["Items"];

    let opps = {};
    opps[ReverseHandTable] = [
        ...items.map(item => ({
            DeleteRequest: {
                Key: {
                    part_key: item.part_key,
                    sort_key: item.sort_key,
                }
            }
        }))
    ];

    opps[ArchivedReverseHandTable] = [
        ...items.map(item => ({
            PutRequest: {
                Item: item
            }
        })) 
    ];

    // deleting bids
    params = {
        RequestItems: {}
    };

    params.RequestItems = opps;

    await docClient.batchWrite(params).promise();

    // archiving advert
    const date = new Date();
    const currentDate = date.getTime();

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
    

    await docClient.put(item).promise();
    resp['advert_details']['id'] = event.arguments.ad_id;
    resp['advert_details']['customer_id'] = resp.customer_id;

    return resp['advert_details'];
};

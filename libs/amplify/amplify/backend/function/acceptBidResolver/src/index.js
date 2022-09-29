const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// add a bid id to an adverts accepted bid
// requires customer id and advert id and shorlisted bid id
exports.handler = async (event) => {
    // getting current date
    const date = new Date();
    const currentDate = date.getTime();

    // getting accepted bid
    let params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.sbid_id,
        }
    };

    const data = await docClient.get(params).promise();
    let tradesman_id = data["Item"]["tradesman_id"];
    let sbid = data["Item"]['bid_details'];

    // adding accepted bid
    let item = {
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_NEW',
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
        UpdateExpression: 'set advert_details.accepted_bid = :ab, expire = :expire',
        ExpressionAttributeValues: {
            ':ab': tradesman_id,
            ':expire': currentDate + (30*24*60*60*1000)
        },
    };

    let ad = await docClient.update(item).promise().then(resp => resp.Attributes);
    let customer_id = ad.customer_id;

    // sending out notification

    const lambda = new AWS.Lambda();
    var notification = lambda.invoke({
        FunctionName: func,
        Payload: JSON.stringify({
            userId: tradesman_id,
            notification: {
                part_key: "notification#" + tradesman_id,
                sort_key: date.toISOString(),
                title: "Bid Accepted",
                msg: "Your bid for " + ad.advert_details.title + " has been shortlisted.",
                type: "BidAccepted",
                timestamp: currentDate
            }
        })
    }).promise();

    //adding the advert_id to the tradesman that won it

    // increase number of adverts won for a tradesman
    await docClient.update({
        TableName: ReverseHandTable,
        Key: {
            part_key: tradesman_id,
            sort_key: tradesman_id
        },
        UpdateExpression: "set finished = finished + :value",
        ExpressionAttributeValues: {
            ":value": 1,
        }
    }).promise();

    await docClient.update({
        TableName: ReverseHandTable,
        Key: {
            part_key: customer_id,
            sort_key: customer_id
        },
        UpdateExpression: "set finished = finished + :value",
        ExpressionAttributeValues: {
            ":value": 1,
        }
    }).promise();

    sbid['tradesman_id'] = tradesman_id;
    sbid['id'] = data["Item"]['sort_key'];

    await notification;

    return sbid;
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// recieves an advert as well as a bid id and adds that bid to the shortlisted bids
exports.handler = async (event) => {
    let params = {};
    params[ReverseHandTable] = {
        Keys: [
            {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id,
            },
            {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id,
            }
        ]
    };

    let items = await docClient.batchGet({
        RequestItems: params
    }).promise();

    // checking if first item is a bid or an advert
    if (items.Responses[ReverseHandTable][0].sort_key[0] == 'a') {
        var ad = items.Responses[ReverseHandTable][0];
        var bid = items.Responses[ReverseHandTable][1];
    } else {
        var ad = items.Responses[ReverseHandTable][1];
        var bid = items.Responses[ReverseHandTable][0];
    }
    
    // notification being sent out
    // getting current date
    if (!bid.bid_details.shortlisted) {
        const date = new Date();
        const currentDate = date.getTime();
    
        const lambda = new AWS.Lambda();
        var notification = lambda.invoke({
            FunctionName: func,
            Payload: JSON.stringify({
                userId: bid.tradesman_id,
                notification: {
                    part_key: "notification#" + bid.tradesman_id,
                    sort_key: date.toISOString(),
                    title: "Bid Shortlisted",
                    msg: "Your bid for " + ad.advert_details.title + " has been shortlisted.",
                    type: "BidShortlisted",
                    timestamp: currentDate
                }
            })
        }).promise();
    }

    await docClient.update({
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.bid_id
        },
        UpdateExpression: `set bid_details.shortlisted = :shortlisted`,
        ExpressionAttributeValues: {
        ":shortlisted": !bid.bid_details.shortlisted,
        },
    }).promise();
    
    if (!bid.bid_details.shortlisted)
        await notification;

    bid.bid_details['id'] = bid.sort_key;
    bid.bid_details['tradesman_id'] = bid.tradesman_id;
    bid.bid_details.shortlisted = !bid.bid_details.shortlisted;

    return bid.bid_details;
};
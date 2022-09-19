const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// recieves an advert as well as a bid id and adds that bid to the shortlisted bids
exports.handler = async (event) => {
    let bid = docClient.update({
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_NEW',
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.bid_id
        },
        UpdateExpression: 'set bid_details.shortlisted = not bid_details.shortlisted',
    }).promise().then(resp => resp.Attributes);

    // getting advert
    let ad = await docClient.get({
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
    }).promise();

    let item = await bid;

    // notification being sent out
    // getting current date
    if (item.bid_details.shortlisted) {
        const date = new Date();
        const currentDate = date.getTime();
    
        const lambda = new AWS.Lambda();
        var notification = lambda.invoke({
            FunctionName: func,
            Payload: JSON.stringify({
                userId: item.tradesman_id,
                notification: {
                    part_key: "notifications#" + item.tradesman_id,
                    sort_key: "notification#" + AWS.util.uuid.v4(),
                    title: "Bid Shortlisted",
                    msg: "Your bid for " + ad.Item.advert_details.title + " has been shortlisted.",
                    type: "BidShortlisted",
                    timestamp: currentDate
                }
            })
        }).promise();
    }
    
    await notification;

    item.bid_details['id'] = item.sort_key;
    item.bid_details['tradesman_id'] = item.tradesman_id;

    return item.bid_details;
};
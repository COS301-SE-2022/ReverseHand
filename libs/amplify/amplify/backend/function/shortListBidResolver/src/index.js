const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// recieves an advert as well as a bid id and adds that bid to the shortlisted bids
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id
            }
        };

        const bidData = await docClient.get(params).promise();

        params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            }
        };

        const adData = await docClient.get(params).promise();
        
        let bid = bidData['Item'];
        let ad = adData['Item'];

        // notification being sent out
        // getting current date
        const date = new Date();
        const currentDate = date.getTime();

        const lambda = new AWS.Lambda();
        let notification = lambda.invoke({
            FunctionName: func,
            Payload: JSON.stringify({
                userId: bid.tradesman_id,
                notification: {
                    title: "Bid Shortlisted",
                    msg: "Your bid for " + ad.advert_details.title + " has been shortlisted.",
                    type: "BidShortlisted",
                    timestamp: currentDate
                }
            })
        }).promise();
        
        // removing from bids
        let del = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id
            },
        }
        await docClient.delete(del).promise();
        
        let shortBidId =  's' + event.arguments.bid_id;
        
        let item = {
            TableName: ReverseHandTable,
            Item: {
                part_key: event.arguments.ad_id,
                sort_key: shortBidId, // prefixing but keeping same suffix
                tradesman_id: bid['tradesman_id'],
                bid_details: {
                    name: bid['bid_details']['name'],
                    price_lower: bid['bid_details']['price_lower'],
                    price_upper: bid['bid_details']['price_upper'],
                    quote: bid['bid_details']['quote'],
                    date_created: bid['bid_details']['date_created'],
                    date_closed: bid['bid_details']['date_closed']
                }
            }
        };

        await docClient.put(item).promise();
        
        item.Item.bid_details['tradesman_id'] = bid['tradesman_id'];
        item.Item.bid_details['id'] = shortBidId;
        
        await notification;
    
        return item.Item.bid_details;
    } catch(e) {
        console.log(e)
        return e;
    }
};
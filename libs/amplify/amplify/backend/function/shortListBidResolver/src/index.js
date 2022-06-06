const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// recieves an advert as well as a bid id and adds that bid to the shortlisted bids
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "user_id = :u and sort_key = :s",
            ExpressionAttributeValues: {
                ":u": event.arguments.ad_id,
                ":s": event.arguments.bid_id
            }
        };

        const data = await docClient.query(params).promise();
        let bid = data["Items"][0];

        let item = {
            TableName: ReverseHandTable,
            Item: {
                user_id: event.arguments.ad_id,
                sort_key: 's' + event.arguments.bid_id, // prefixing but keeping same suffix
                bid_details: {
                    price_lower: ibidtem['bid_details']['price_lower'],
                    price_upper: bid['bid_details']['price_upper'],
                    quote: item['bid_details']['quote'],
                    date_created: bid['bid_details']['date_created'],
                    date_closed: bid['bid_details']['date_closed']
                }
            }
        };

        await docClient.putItem(item);
    
        return item.Item;
    } catch(e) {
        console.log(e)
        return e;
    }
};

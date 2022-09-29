const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
*/

// places a bid on an advert, requires the bid to place as well as the id the advert to place the bid
// the tradesmans id should also be passed in
exports.handler = async (event) => {
    // getting current date
    const date = new Date();
    const currentDate = date.getTime();

    const bid_id = "b#" + AWS.util.uuid.v4();
    
    let item = {
        part_key: event.arguments.ad_id,
        sort_key: bid_id, // prefixing but keeping same suffix
        tradesman_id: event.arguments.tradesman_id,
        bid_details: {
            name: event.arguments.name,
            price: event.arguments.price,
            quote: event.arguments.quote, //optional parameter
            date_created: currentDate,
            shortlisted: false,
        }
    };

    let data = await docClient.get({
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id, // id is the Partition Key, '123' is the value of it
        },
    }).promise();

    let advert = data['Item'];

    const lambda = new AWS.Lambda();
    var notification = lambda.invoke({
        FunctionName: func,
        Payload: JSON.stringify({
            userId: advert.customer_id,
            notification: {
                part_key: "notification#" + advert.customer_id,
                sort_key: date.toISOString(),
                title: "Bid Placed",
                msg: "A bid has been placed on " + advert.advert_details.title,
                type: "BidPlaced",
                timestamp: currentDate
            }
        })
    }).promise();

    await docClient.transactWrite({
        TransactItems: [
            {
                Put: {
                    TableName: ReverseHandTable,
                    Item: item
                }
            },
            {
                Update: {
                    TableName: ReverseHandTable,
                    Key: {
                        part_key: event.arguments.tradesman_id,
                        sort_key: event.arguments.tradesman_id
                    },
                    UpdateExpression: "set created = created + :value",
                    ExpressionAttributeValues: {
                        ":value": 1,
                    }
                }
            }
        ]
    }).promise();

    item.bid_details['id'] = bid_id; // bids id to be returned
    item.bid_details['tradesman_id'] = item.tradesman_id;

    await notification;

    return item.bid_details;
};

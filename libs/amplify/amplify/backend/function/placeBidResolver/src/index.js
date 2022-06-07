const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
*/

// places a bid on an advert, requires the bid to place as well as the id the advert to place the bid
// created_date will be made in resolver whereas UUID ofbid will be passed in
exports.handler = async (event) => {
    // getting current date
    const date = new Date();
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = date.getFullYear();
    const currentDate = mm + '-' + dd + '-' + yyyy;

    let item = {
        TableName: ReverseHandTable,
        Item: {
            user_id: event.arguments.ad_id,
            sort_key: event.arguments.bid_id, // prefixing but keeping same suffix
            bid_details: {
                id: event.arguments.bid_id,
                user: event.arguments.user_id,
                price_lower: event.arguments.price_lower,
                price_upper:event.arguments.price_upper,
                quote: event.arguments.quote, //optional parameter
                date_created: currentDate,
            }
        }
    };

    await docClient.put(item).promise();

    return item.Item.bid_details;
};

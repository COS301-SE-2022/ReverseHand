const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, context) => {
    // console.log(event);
    // console.log(context);

    try {
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "user_id = :u",
            ExpressionAttributeValues: {
                ":u": event.arguments.ad_id,
            }
        };
        const data = await docClient.query(params).promise();
        console.log(data["Items"]);
        let items = data["Items"];
        
        let bids = [];
        for (let item of items) {
            bids.push({
                id: item['sort_key'],
                advert_id: item['user_id'], // since this is the advert we searched for
                user_id: item['user'],
                price_lower: item['price_lower'],
                price_upper: item['price_upper'],
                quote: item['quote'],
                date_created: item['date_created'],
                date_closed: item['date_closed']
            });
        }

        return bids;
    } catch(e) {
        console.log(e)
        return e;
    }
};

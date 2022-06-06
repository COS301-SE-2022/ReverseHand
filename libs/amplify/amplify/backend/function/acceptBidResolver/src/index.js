const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// add a bid id to an adverts accepted bid
// requires customer id and advert id and shorlisted bid id
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "user_id = :u and sort_key = :a",
            ExpressionAttributeValues: {
                ":u": event.arguments.user_id,
                ":a": event.arguments.ad_id
            }
        };

        const data = await docClient.query(params).promise();
        let ad = data["Items"][0]; // should only return one item
        
        let item = {
            TableName: ReverseHandTable,
            Item: {
                user_id: event.arguments.ad_id,
                sort_key: event.arguments.ad_id, // prefixing but keeping same suffix
                advert_details: {
                    accepted_bid: sbid_id,
                }
            }
        };

        await docClient.put(item).promise();
    
        return item.Item.advert_details;
    } catch(e) {
        console.log(e)
        return e;
    }
};

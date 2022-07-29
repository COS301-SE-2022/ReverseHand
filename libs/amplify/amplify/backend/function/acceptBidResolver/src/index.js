const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// add a bid id to an adverts accepted bid
// requires customer id and advert id and shorlisted bid id
exports.handler = async (event) => {
    // adding accepted bid
    try {
        let item = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            },
            UpdateExpression: 'set advert_details.accepted_bid = :ab',
            ExpressionAttributeValues: {
                ':ab': event.arguments.sbid_id,
            },
        };

        await docClient.update(item).promise();
        
        // getting accepted bi
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "part_key = :p and sort_key = :s",
            ExpressionAttributeValues: {
                ":p": event.arguments.ad_id,
                ":s": event.arguments.sbid_id
            }
        };

        const data = await docClient.query(params).promise();
        let sbid = data["Items"][0]['bid_details'];
    
        return sbid;
    } catch(e) {
        console.log(e)
        return e;
    }
};

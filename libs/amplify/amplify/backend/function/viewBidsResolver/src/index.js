const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, context) => {
    // console.log(event.arguments.advert_id);
    // console.log(context);

    let table;
    if (event.arguments.archived)
        table = ArchivedReverseHandTable;
    else
        table = ReverseHandTable;

    try {
        let params = {
            TableName: table,
            KeyConditionExpression: "part_key = :p and begins_with(sort_key, :b)",
            ExpressionAttributeValues: {
                ":p": event.arguments.ad_id,
                ":b": "b#",
            }
        };
        let data = await docClient.query(params).promise();
        // console.log(data);
        let items = data["Items"];
        
        let bids = [];
        for (let item of items) {
            bids.push({
                id: item['sort_key'],
                advert_id: event.arguments.ad_id, // since this is the advert we searched for
                tradesman_id: item['tradesman_id'],
                name: item['bid_details']['name'],
                price: item['bid_details']['price'],
                quote: item['bid_details']['quote'],
                date_created: item['bid_details']['date_created'],
                date_closed: item['bid_details']['date_closed'],
                shortlisted: item['bid_details']['shortlisted']
            });
        }

        return bids;
    } catch(e) {
        console.log(e)
        return e;
    }
};

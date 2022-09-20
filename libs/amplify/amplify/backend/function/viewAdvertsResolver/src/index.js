const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
// this function is used to retrieve the bids for a specific consumer

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            IndexName: "customer_view",
            KeyConditionExpression: "customer_id = :p",
            ExpressionAttributeValues: {
                ":p": event.arguments.user_id, // should be a consumers id
            }
        };

        const data = await docClient.query(params).promise();
        let items = data["Items"];

        let adverts = [];
        for (let item of items) 
            adverts.push({
                id: item['part_key'],
                customer_id: item['customer_id'],
                title: item['advert_details']['title'],
                description: item['advert_details']['description'],
                type: item['advert_details']['type'],
                bids: item['advert_details']['bids'],
                shortlisted_bids: item['advert_details']['shortlisted_bids'],
                accepted_bid: item['advert_details']['accepted_bid'],
                customer_id: item['customer_id'],
                domain: item['advert_details']['domain'],
                date_created: item['advert_details']['date_created'],
                date_closed: item['advert_details']['date_closed'],
            });

        return adverts;
    } catch(e) {
        return e;
    }
};

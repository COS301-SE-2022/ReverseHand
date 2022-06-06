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
            KeyConditionExpression: "user_id = :u",
            ExpressionAttributeValues: {
                ":u": event.arguments.user_id, // should be a consumers id
            }
        };

        const data = await docClient.query(params).promise();
        let items = data["Items"];

        let adverts = [];
        for (let item of items)
            adverts.push({
                id: item['sort_key'],
                title: item['title'],
                description: item['description'],
                type: item['type'],
                bids: item['bids'],
                shortlisted_bids: item['shortlisted_bids'],
                accepted_bid: item['accepted_bid'],
                user_id: item['user_id'],
                location: item['location'],
                date_created: item['date_created'],
                date_closed: item['date_closed'],
            });

        return adverts;
    } catch(e) {
        return e;
    }
};

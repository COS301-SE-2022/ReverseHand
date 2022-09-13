const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const TradesmanViewIndex = process.env.TRADESMAN;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// get all the adverts which a tradesman has bid on
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        IndexName: TradesmanViewIndex,
        KeyConditionExpression: 'tradesman_id = :id',
        ExpressionAttributeValues: {
            ':id': event.arguments.tradesman_id
        }
    }).promise();
    

    let items = {};
    items[ReverseHandTable] = {
        Keys: response.Items.map((el) => {
            return {
                part_key: el.part_key,
                sort_key: el.part_key
            };
        }),
    };
    
    let adverts = await docClient.batchGet({
        RequestItems: items
    }).promise();

    return adverts.Responses[ReverseHandTable].map((el) => {
        el.advert_details['id'] = el.part_key;
        return el.advert_details;
    });
};

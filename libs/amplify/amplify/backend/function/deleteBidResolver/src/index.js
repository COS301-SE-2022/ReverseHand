const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

//Bid id and perhaps advert id necessary to delete a bid?

exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        ReturnValues: "ALL_OLD",
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.bid_id
        },
    };

    //deleting the bid
    let item = await docClient.delete(params).promise().then(data => data.Attributes);

    // archiving the bid
    await docClient.put({
        TableName: ArchivedReverseHandTable,
        Item: item
    }).promise();

    item['bid_details']['id'] = item['sort_key'];
    item['bid_details']['tradesman_id'] = item['tradesman_id'];

    return item['bid_details'];
};

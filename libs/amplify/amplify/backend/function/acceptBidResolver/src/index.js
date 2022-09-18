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
    let item = {
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_NEW',
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
        UpdateExpression: 'set advert_details.accepted_bid = :ab',
        ExpressionAttributeValues: {
            ':ab': event.arguments.sbid_id,
        },
    };

    let customer_id = await docClient.update(item).promise().then(resp => resp.Attributes.customer_id);
    
    // getting accepted bid
    let params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.sbid_id,
        }
    };

    const data = await docClient.get(params).promise();
    let tradesman_id = data["Item"]["tradesman_id"];
    let sbid = data["Item"]['bid_details'];

    //adding the advert_id to the tradesman that won it

    // increase number of adverts won for a tradesman
    await docClient.update({
        TableName: ReverseHandTable,
        Key: {
            part_key: tradesman_id,
            sort_key: tradesman_id
        },
        UpdateExpression: "set finished = :finished + :value",
        ExpressionAttributeValues: {
            ":value": 1,
        }
    });

    await docClient.update({
        TableName: ReverseHandTable,
        Key: {
            part_key: customer_id,
            sort_key: customer_id
        },
        UpdateExpression: "set finished = :finished + :value",
        ExpressionAttributeValues: {
            ":value": 1,
        }
    });

    sbid['tradesman_id'] = tradesman_id;

    return sbid;
};

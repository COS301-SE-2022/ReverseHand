const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

// function gets tradesman id from bid and deletes chat
// this must be changed later

// takes consumer_id and sbid id and ad_id

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.ad_id
        },
    };

    let data = await docClient.get(params).promise();
    
    params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: data['Item']['advert_details']['accepted_bid'],
        },
    };
    
    data = await docClient.get(params).promise();

    params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.c_id,
            sort_key: data['Item']['bid_details']['tradesman_id'],
        },
    }

    data = await docClient.get(params).promise();

    await docClient.delete(params).promise();
    
    params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            },
            UpdateExpression: 'set advert_details.#date_closed = :d',
            ExpressionAttributeValues: {
                ':d': 'closed',
            },
            ExpressionAttributeNames: {
                '#date_closed': 'date_closed',
            },
        };

    await docClient.update(params).promise();

    return data['Item'];
};

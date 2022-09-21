const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

//Currently editing : price_lower, price_upper and quote
exports.handler = async (event) => {
    let args = [];
    let expressionAttributeNames = {};

    if(event.arguments.quote !== undefined)
    {
        args.push('bid_details.#quote = :quote');
        expressionAttributeNames['#quote'] = 'quote';
    }
    if(event.arguments.price !== undefined)
    {
        args.push('bid_details.#price = :price');
        expressionAttributeNames['#price'] = 'price';
    }

    let updateExpression = 'set ';
    for (let i = 0; i < args.length - 1; i++)
        updateExpression += args[i] + ', ';
    updateExpression += args[args.length - 1];

    let expressionAttributeValues = {};

    expressionAttributeValues[':quote'] = event.arguments.quote;
    expressionAttributeValues[':price'] = event.arguments.price;

    let params = {
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_NEW',
        Key: {
            part_key: event.arguments.ad_id,
            sort_key: event.arguments.bid_id
        },
        UpdateExpression: updateExpression,
        ExpressionAttributeValues: expressionAttributeValues,
        ExpressionAttributeNames: expressionAttributeNames,
    };

    let data = await docClient.update(params).promise().then(resp => resp.Attributes);
    
    data['bid_details']['id'] = data.sort_key;
    data['bid_details']['tradesman_id'] = data.tradesman_id;

    return data['bid_details'];
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

//Currently editing : price_lower, price_upper and quote
exports.handler = async (event) => {
    try {
        let args = [];
        let expressionAttributeNames = {};

        if(event.arguments.quote !== undefined)
        {
            args.push('bid_details.#quote = :quote');
            expressionAttributeNames['#quote'] = 'quote';
        }
        if(event.arguments.price_lower !== undefined)
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
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        };

        await docClient.update(params).promise();

        //getting item to be returned
        params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id
            }
        };

        const data = await docClient.get(params).promise();

        return data.Item['bid_details'];

    } catch (error) {
        console.log(error);
    }
};

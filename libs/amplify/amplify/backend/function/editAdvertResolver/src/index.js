const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// edits and existing advert
/*
    advert_id
    **all attributes regarding the advert**
    // not including date created as that cannot change, can't edit customer_id either
    // paramters must have same name as attributes in table for ease of use
*/
exports.handler = async (event) => {
    try {
        // updating item
        let args = [];
        let expressionAttributeNames = {};
        if (event.arguments.title !== undefined) {
            args.push('advert_details.#title = :title');
            expressionAttributeNames['#title'] = 'title';
        }
        if (event.arguments.description !== undefined) {
            args.push('advert_details.#description = :description');
            expressionAttributeNames['#description'] = 'description';
        }
        if (event.arguments.type !== undefined) {
            args.push('advert_details.#type = :type');
            expressionAttributeNames['#type'] = 'type';
        }
        if (event.arguments.location !== undefined) {
            args.push('advert_details.#location = :location');
            expressionAttributeNames['#location'] = 'location';
        }
        if (event.arguments.date_closed !== undefined) {
            args.push('advert_details.#date_closed = :date_closed');
            expressionAttributeNames['#date_closed'] = 'date_closed';
        }
            
        let updateExpression = 'set ';
        for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
        let expressionAttributeValues = {

        };
        expressionAttributeValues[':title'] = event.arguments.title;
        expressionAttributeValues[':description'] = event.arguments.description;
        expressionAttributeValues[':type'] = event.arguments.type;
        expressionAttributeValues[':location'] = event.arguments.location;
        expressionAttributeValues[':date_closed'] = event.arguments.date_closed;

        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.advert_id,
                sort_key: event.arguments.advert_id
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        }

        await docClient.update(params).promise();

        // getting item to be returned
        params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            }
        };

        const data = await docClient.get(params).promise();

        return data['advert_details'];
    } catch(e) {
        console.log(e);
    }
};
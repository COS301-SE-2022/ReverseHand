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
        // checking if there are existing bids
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "part_key = :p and begins_with(sort_key, :b)",
            ExpressionAttributeValues: {
                ":p": event.arguments.ad_id,
                ":b": "b#"
            }
        };
        let data = await docClient.query(params).promise();
        let items = data["Items"];

        if (items.length !== 0)
            throw "Advert contains bids";

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
        if (event.arguments.images !== undefined) {
            args.push('advert_details.#images = :images');
            expressionAttributeNames['#images'] = 'images';
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
        expressionAttributeValues[':images'] = event.arguments.images;

        params = {
            TableName: ReverseHandTable,
            ReturnValues: 'ALL_NEW',
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        };

        let ad = await docClient.update(params).promise().then(resp => resp.Attributes);

        ad['advert_details']['id'] = event.arguments.ad_id;
        ad['advert_details']['customer_id'] = event.arguments.customer_id;

        return ad['advert_details'];
};
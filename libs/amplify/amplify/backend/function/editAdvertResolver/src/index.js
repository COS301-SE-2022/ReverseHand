const AWS = require("aws-sdk");
const { updateExpressionStatement } = require("typescript");
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
        let updateExpression = {
            advert_details: {}
        };
        updateExpression.advert_details['title'] = event.arguments.title;
        updateExpression.advert_details['description'] = event.arguments.description;
        updateExpression.advert_details['type'] = event.arguments.type;
        updateExpression.advert_details['location'] = event.arguments.location;
        updateExpression.advert_details['date_closed'] = event.arguments.date_closed;

        let setString = 'set ';

        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.advert_id,
                sort_key: event.arguments.advert_id
            },
            UpdateExpression: updateExpression,
        }

        await docClient.update(params).promise();

        return 'test for now';
    } catch(e) {
        console.log(e);
    }
};

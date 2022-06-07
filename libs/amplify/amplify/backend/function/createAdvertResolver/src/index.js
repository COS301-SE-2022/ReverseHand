const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// creates a new advert, requires
/*
    id: uniquely generated, passed in to avoid working with layers
    customerId
    title
*/
// Optional
/*
    description
    type
    location // will become required later on
*/
exports.handler = async (event) => {
    // getting current date
    const date = new Date();
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = date.getFullYear();
    const currentDate = mm + '/' + dd + '/' + yyyy;

    let item = {
        TableName: ReverseHandTable,
        Item: {
            user_id: event.arguments.customer_id,
            sort_key: event.arguments.ad_id, // prefixing but keeping same suffix
            advert_details: {
                id: event.arguments.ad_id,
                title: event.arguments.title,
                description: event.arguments.description,
                location: event.arguments.location,
                date_created: currentDate // automatically generating the date
            }
        }
    };

    await docClient.put(item).promise();

    return item.Item.advert_details;
};

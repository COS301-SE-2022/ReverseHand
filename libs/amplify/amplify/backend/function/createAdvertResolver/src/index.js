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
    try {
        const ad_id = "a#" + AWS.util.uuid.v4();

        // getting current date
        const date = new Date();
        const currentDate = date.getTime();
        
        let params = {
            TableName: ReverseHandTable,
            Key: {
              part_key: event.arguments.domain.city,
              sort_key: event.arguments.type
            },
            UpdateExpression: `set advert_list = list_append(if_not_exists(advert_list,:list),:ad)`,
            ExpressionAttributeValues: {
              ":ad": [ad_id],
              ":list": []
            },
        };
        
        await docClient.update(params).promise(); //adding the advert to the list of adverts within the location and type

        let item = {
            TableName: ReverseHandTable,
            Item: {
                part_key: ad_id,
                sort_key: ad_id, // prefixing but keeping same suffix
                customer_id: event.arguments.customer_id,
                advert_details: {
                    title: event.arguments.title,
                    description: event.arguments.description,
                    domain: event.arguments.domain,
                    type: event.arguments.type,
                    date_created: currentDate // automatically generating the date
                }
            }
        };
        await docClient.put(item).promise();
    
        item.Item.advert_details['id'] = ad_id; // adding advert id to be returned
        return item.Item.advert_details;
    } catch(e) {
        console.log(e);
    }
};

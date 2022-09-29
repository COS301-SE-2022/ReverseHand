const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// deletes an advert, requires
/*
    ad_id
*/
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            Key: {
              part_key: event.arguments.ad_id,
              sort_key: event.arguments.ad_id
            },
        };

        // getting advert
        const data = await docClient.get(params).promise();
        

        // deleting advert
        await docClient.delete(params).promise();
        
        data['Item']['advert_details']['id'] = event.arguments.ad_id;
        return data['Item']['advert_details'];
    } catch(e) {
        console.log(e);
    }
    // getting current date
};

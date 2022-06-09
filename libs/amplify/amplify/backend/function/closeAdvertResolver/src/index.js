const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// add a date_closed field to an advert_details map
// requires customer id and advert id
exports.handler = async (event) => {
    
    const date = new Date();
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = date.getFullYear();
    const currentDate = mm + '-' + dd + '-' + yyyy;
    
    try {
        let item = {
            TableName: ReverseHandTable,
            Key: {
                user_id: event.arguments.user_id,
                sort_key: event.arguments.ad_id
            },
            UpdateExpression: 'set date_closed = :dc',
            ExpressionAttributeValues: {
                ':dc': currentDate,
            },
        };

        console.log(item);


        await docClient.update(item).promise();
        
        // getting closed advert
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "user_id = :u and sort_key = :s",
            ExpressionAttributeValues: {
                ":u": event.arguments.user_id,
                ":s": event.arguments.ad_id
            }
        };

        console.log(params);
        
        const data = await docClient.query(params).promise();
        console.log(data);
    
    } catch(e) {
        console.log(e)
        return e;
    }
};

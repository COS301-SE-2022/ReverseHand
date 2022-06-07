const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
*/
exports.handler = async (event) => {
    const date = new Date();
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = date.getFullYear();
    const currentDate = mm + '-' + dd + '-' + yyyy;
    
    try {
   
        await docClient.update({
            TableName: ReverseHandTable,
            Key: {
                user_id: event.arguments.user_id,
                sortkey: event.arguments.ad_id
            },
            UpdateExpression: 'set date_closed = :dc', 
            ExpressionAttributeValues: {
                ':dc': currentDate,
            },
        }).promise();

        const data = await docClient.query({
            TableName: ReverseHandTable,
            KeyConditionExpression: "user_id = :u and sort_key = :s",
            ExpressionAttributeValues: {
                ":u": event.arguments.user_id,
                ":s": event.arguments.ad_id
            }
        })

        let closed_advert = data["Items"][0]['advert_details']

        return closed_advert;

    } catch (e) {
        console.log(e)
        return e;
    }
};

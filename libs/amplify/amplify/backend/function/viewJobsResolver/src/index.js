const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async () => {
    
    try {
       let params = {
           TableName: ReverseHandTable,
           FilterExpression: 'contains(sort_key, :ad)',
           ExpressionAttributeValues: {
                ':ad' : 'a#' ,
           }
       }
       
       const data = await docClient.scan(params).promise()
       
       let adverts = [];
            for (let item of data.Items)
                adverts.push({
                    id: item['sort_key'],
                    user_id: item['user_id'],
                    title: item.advert_details['title'],
                    description: item.advert_details['description'],
                    type: item.advert_details['type'],
                    bids: item.advert_details['bids'],
                    shortlisted_bids: item.advert_details['shortlisted_bids'],
                    accepted_bid: item.advert_details['accepted_bid'],
                    location: item.advert_details['location'],
                    date_created: item.advert_details['date_created'],
                    date_closed: item.advert_details['date_closed'],
                });
    
            return adverts;
            
    } catch (e) {
        return e
    }
};

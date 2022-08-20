const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            Key : {
                part_key: event.arguments.scope,
                sort_key: event.arguments.city
            },
        };
        let data = await docClient.get(params).promise();
        console.log(data);
        let advert_reports = data.Item.advert_reports;
        
        let advert_keys = [];
        advert_reports.forEach(function(ad_id) {
            advert_keys.push({part_key: ad_id, sort_key: ad_id});
        });
        
        params = {
        RequestItems: {},
      };
      
      params.RequestItems[ReverseHandTable] = {Keys: advert_keys};
      
      
      data = await docClient.batchGet(params).promise();
      return data;
        
    } catch (e) {
        console.log(e);
    }
};

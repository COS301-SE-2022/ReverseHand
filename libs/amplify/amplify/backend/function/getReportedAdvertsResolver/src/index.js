const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   let params = {
        TableName: ReverseHandTable,
        IndexName: "admin_batch_lists_view",
        KeyConditionExpression: "province_id = :p",
        ExpressionAttributeValues: {
            ":p": event.arguments.province
        }
    };
        
    const response = await docClient.query(params).promise().then((data) => data.Items);
    //if the response is empty there are no adverts in this province
    if (response.length == 0) {
        return response;
    }
    
    //build keys for batch_get
    let concat_reports_list = [];
    response.forEach(function (item) {
        item.reports_list.forEach((ad_id) => concat_reports_list.push({part_key: ad_id, sort_key: ad_id}));
    });
    
    params = {
        RequestItems: {},
    };
      
    params.RequestItems[ReverseHandTable] = {Keys: concat_reports_list};
    
    let adverts = await docClient.batchGet(params).promise().then((data) => data.Responses.ReverseHand);
    let result = [];
    adverts.forEach(function (advert) {
        let obj = {};
        obj.id = advert.report_id
        obj.advert_details = advert.advert_details;
        obj.advert_details.id = advert.part_key;
        obj.customer_id = advert.customer_id;
        obj.admin_reports = advert.admin_reports;
        obj.count = obj.admin_reports.length;
        result.push(obj);
    });
    
    return result;
    
    
    
};

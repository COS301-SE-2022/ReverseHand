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
        return "No adverts";
    }
    
    //build keys for batch_get
    let concat_reports_list = [];
    response.forEach(function (item) {
        if (item.reports_list != null) {
            concat_reports_list = [...concat_reports_list, ...item.reports_list];
        }
    });
    
    if (concat_reports_list.length == 0) {
        return "No reported adverts";
    }
    params = {
        RequestItems: {},
    };
      
    params.RequestItems[ReverseHandTable] = {Keys: concat_reports_list};
    
    let adverts = await docClient.batchGet(params).promise().then((data) => data.Responses.ReverseHand);
    let result = [];
    adverts.forEach(function (advert) {
        let obj = {};
        obj.advert = advert.advert_details;
        obj.advert.id = advert.part_key;
        obj.advert.customer_id = advert.customer_id;
        obj.reports = advert.admin_reports;
        obj.count = obj.reports.length;
        result.push(obj);
    });
    
    return result;
    
};

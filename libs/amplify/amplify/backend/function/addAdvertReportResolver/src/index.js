const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    
    let paramsGetAdvert = {
      TableName: ReverseHandTable,
      Key: {
        part_key: event.arguments.advert_id,
        sort_key: event.arguments.advert_id
      },
    };
    
    const advert = await docClient.get(paramsGetAdvert).promise().then((resp) => resp.Item);
    
    if (advert.admin_reports == null) {
      advert.admin_reports = [];
      const advert_details = advert.advert_details;
      let paramsUpdateReportsList = {
        TableName: ReverseHandTable,
        ReturnValues: 'ALL_NEW',
        Key: {
          part_key: advert_details.domain.city + "#" + advert_details.domain.province,
          sort_key: advert_details.type
        },
        UpdateExpression: `set reports_list = list_append(if_not_exists(reports_list,:list),:ad), province_id = if_not_exists(province_id, :p_id)`,
        ExpressionAttributeValues: {
          ":ad": [{part_key: event.arguments.advert_id, sort_key: event.arguments.advert_id}],
          ":list": [],
          ":p_id" : advert_details.domain.province
        },
      };
        
      await docClient.update(paramsUpdateReportsList).promise().then((resp) => resp.Attributes);
      
    } else if (advert.admin_reports.some(report => report.reporter_id == event.arguments.report.reporter_id)) {
        return "Advert already reported";
    }
    
    advert.admin_reports.push(event.arguments.report);
    
    let paramsPutAdvert = {
      TableName: ReverseHandTable,
      Item : advert
    };
    
    await docClient.put(paramsPutAdvert).promise();
    
    if (advert.admin_reports.length > 5) {
      
    }
    
    return advert;
};

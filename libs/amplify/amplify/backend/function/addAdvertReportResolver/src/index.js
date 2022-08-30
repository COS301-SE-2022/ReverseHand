const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    
    let params = {
      TableName: ReverseHandTable,
      ReturnValues: 'ALL_OLD',
      Key: {
        part_key: event.arguments.advert_id,
        sort_key: event.arguments.advert_id
      },
      UpdateExpression: `set admin_reports = list_append(if_not_exists(admin_reports,:list),:report), report_id = if_not_exists(report_id,:report_id)`,
      ExpressionAttributeValues: {
        ":report": [event.arguments.report],
        ":list" : [],
        ":report_id": "ar#" + AWS.util.uuid.v4()
      },
    };
    
    const old_advert = await docClient.update(params).promise().then((resp) => resp.Attributes);
    if (old_advert.report_id == null) {
      const advert_details = old_advert.advert_details;
      let params = {
          TableName: ReverseHandTable,
          ReturnValues: 'ALL_NEW',
          Key: {
            part_key: advert_details.domain.city + "#" + advert_details.domain.province,
            sort_key: advert_details.type
          },
          UpdateExpression: `set reports_list = list_append(if_not_exists(reports_list,:list),:ad)`,
          ExpressionAttributeValues: {
            ":ad": [event.arguments.advert_id],
            ":list": []
          },
        };
        
      await docClient.update(params).promise();
    } else if (old_advert.admin_reports.length + 1 > 5) {
      //archive advert when archive table set up
    };
    
    return old_advert;
};

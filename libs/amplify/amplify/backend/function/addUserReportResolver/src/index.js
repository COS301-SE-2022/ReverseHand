const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  
  event.arguments.report.reporter_id = event.arguments.user_id;
  let paramsPutReport = {
    TableName: ReverseHandTable,
    Item: {
      part_key: "user_reports#" + event.arguments.report.reported_user_id,
      sort_key: "report#" + AWS.util.uuid.v4(),
      report_details: event.arguments.report,
      report_type: "user#reports"
    }
  };

  await docClient.put(paramsPutReport).promise();
  
  paramsPutReport.Item.report_details.id = paramsPutReport.Item.sort_key;
  delete paramsPutReport.Item.sort_key;
  return paramsPutReport.Item.report_details;
};

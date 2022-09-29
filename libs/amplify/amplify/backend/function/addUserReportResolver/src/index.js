const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  let report = event.arguments.report;
  report.reporter_user = {
    id: event.arguments.user_details.id,
    name: event.arguments.user_details.name
  };

  let paramsPutReport = {
    TableName: ReverseHandTable,
    Item: {
      part_key: "user_reports#" + event.arguments.report.reported_user.id,
      sort_key: "report#" + AWS.util.uuid.v4(),
      report_details: report,
      report_type: "user#reports"
    }
  };

  await docClient.put(paramsPutReport).promise();
  
  paramsPutReport.Item.id = paramsPutReport.Item.sort_key;
  delete paramsPutReport.Item.sort_key; 
  delete paramsPutReport.Item.part_key;
  return paramsPutReport.Item.report_details;
};

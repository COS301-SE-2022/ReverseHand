const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {

  let paramsDeleteUserReport = {
    TableName: ReverseHandTable,
    ReturnValues: "ALL_OLD",
    Key: {
      part_key: "user_reports#" + event.arguments.user_id,
      sort_key: event.arguments.report_id
    }
  };

  let report = await docClient.delete(paramsDeleteUserReport).promise().then(data => data.Attributes);

  if (event.arguments.issueWarning) {
    let paramsUpdateUser = {
      TableName: ReverseHandTable,
      Key: {
        part_key: event.arguments.user_id,
        sort_key: event.arguments.user_id
      },
      UpdateExpression: `set warnings = warnings + :count`,
      ExpressionAttributeValues: {
        ":count": 1
      },
    };

    await docClient.update(paramsUpdateUser).promise();

  }

  return report.report_details;
  
};

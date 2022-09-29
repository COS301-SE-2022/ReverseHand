const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  let paramsDeleteReport = {
    TableName: ReverseHandTable,
    ReturnValues: "ALL_OLD",
    Key: {
      part_key: "review_reports#" + event.arguments.user_id,
      sort_key: event.arguments.report_id
    }
  };

  let report_item = await docClient.delete(paramsDeleteReport).promise().then(data => data.Attributes);
  if (report_item == undefined)
    throw "No report found";

  let report_details = report_item.report_details;
  let review_details = report_item.review_details;
  if (event.arguments.issueWarning) {
    await docClient.transactWrite({
      TransactItems:
        [
          {
            Delete: {
              TableName: ReverseHandTable,
              Key: {
                part_key: "reviews#" + report_details.reporter_id,
                sort_key: review_details.id
              }
            }
          },
          {
            Update: {
              TableName: ReverseHandTable,
              Key: {
                part_key: event.arguments.user_id,
                sort_key: event.arguments.user_id
              },
              UpdateExpression: `set warnings = warnings + :count`,
              ExpressionAttributeValues: {
                ":count": 1
              },
            }
          }
        ],
    }).promise();
  }

  return report_details;
};

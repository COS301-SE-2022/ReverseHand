const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let paramsGetReview = {
      TableName: ReverseHandTable,
      Key: {
        part_key: "reviews#" + event.arguments.user_id,
        sort_key: event.arguments.review_id
      }
    };
    
    let review = await docClient.get(paramsGetReview).promise().then(data=>data.Item);
    review.review_details.id = review.sort_key;
    delete review.part_key; delete review.sort_key;
    
    event.arguments.report.reporter_id = event.arguments.user_id;
    let paramsPutReport = {
      TableName: ReverseHandTable,
      Item : {
        part_key: "review_reports#" + event.arguments.report.reported_user_id,
        sort_key: "report#" + AWS.util.uuid.v4(),
        review_details: review.review_details,
        report_details: event.arguments.report,
        report_type: "review#reports"
      }
    };
    
    
    await docClient.put(paramsPutReport).promise();
    paramsPutReport.Item.report_details.id = paramsPutReport.Item.sort_key;
    return paramsPutReport.Item.report_details;
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
            TableName: ReverseHandTable,
            IndexName: "report-type-index",
            KeyConditionExpression: "report_type = :t",
            ExpressionAttributeValues: {
                ":t": event.arguments.type, 
            }
        };
    let resp  = await docClient.query(params).promise();
    
    let reported_items = resp.Items;
    reported_items.forEach(function(report) {
        report.id = report.sort_key;
        delete report.sort_key;
        
        if (event.arguments.type == "review#reports") {
            report.user_id = report.part_key.substring(15,report.part_key.length);
            delete report.part_key;
            delete report.review_details.user_id;
            delete report.review_details.date_created;
        } else delete report.part_key;

    });
    
    let result = {
        reports: reported_items,
        next_token: resp.nextToken ?? null
    }; 
    
    return result;
    
};
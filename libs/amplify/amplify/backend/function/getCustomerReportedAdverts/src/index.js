const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

//This function is to fetch all reported adverts related to a single customer

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   try {
       let params = {
            TableName: ReverseHandTable,
            IndexName: "admin_customer_view",
            KeyConditionExpression: "customer_id = :p",
            ExpressionAttributeValues: {
                ":p": event.arguments.customer_id, // should be a consumers id
            }
        };
        
        let data = await docClient.query(params).promise();
        let response = [];
        data.Items.forEach(function(advert) {
            advert.advert_details.id = advert.part_key;
            let count = advert.admin_reports.count;
            delete advert.admin_reports.count;
            response.push({
                id: advert.report_id,
                count: count,
                advert: advert.advert_details,
                reports: advert.admin_reports.reports
            });
        });
        
        return response;
   } catch(e) {}
};

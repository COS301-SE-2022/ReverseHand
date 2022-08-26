const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    
    let params = {
            TableName: ReverseHandTable,
            Key: {
              part_key: event.arguments.advert_id,
              sort_key: event.arguments.advert_id
            },
            UpdateExpression: `set admin_reports = list_append(if_not_exists(admin_reports,:list),:report), report_id = :report_id`,
            ExpressionAttributeValues: {
              ":report": [event.arguments.report],
              ":list" : [],
              ":report_id": "ar#" + AWS.util.uuid.v4()
            },
        };
        
        console.log(params);
        
        const data = await docClient.update(params).promise();
        return data;
    
};

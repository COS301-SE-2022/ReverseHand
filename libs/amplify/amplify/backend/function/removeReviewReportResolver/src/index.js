const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   let params = {
      TableName: UserTable,
      Key: {
        user_id: event.arguments.user_id,
      }
    };
    
    let user = await docClient.get(params).promise().then((resp) => resp.Item);
    
    let report = user.review_reports.filter(review => review.id == event.arguments.review_id);
    user.review_reports = user.review_reports.filter(review => review.id != event.arguments.review_id);
    
    if (user.review_reports.length == 0) {
        delete user.review_reports;
        
        let params = {
            TableName: UserTable,
            Key: {
                user_id: "reported#reviews",
            }
        };
        
        let review_reports_item = await docClient.get(params).promise().then((resp) => resp.Item);
        if (event.arguments.user_id[0] == "c") {
            review_reports_item.customers.filter(user => user.user_id != event.arguments.user_id);
        } else {
            review_reports_item.tradesmen.filter(user => user.user_id != event.arguments.user_id);
        }
        
        params = {
        TableName: UserTable,
        Item: review_reports_item
      };
      
      await docClient.put(params).promise();
    }
    
    params = {
      TableName: UserTable,
      Item: user
    };
    
    await docClient.put(params).promise();
    
    return report;
};

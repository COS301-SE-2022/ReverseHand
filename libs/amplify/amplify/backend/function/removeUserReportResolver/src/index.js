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
    
    let report = user.user_reports.filter(report => report.reporter_id == event.arguments.reporter_id);
    user.user_reports = user.user_reports.filter(report => report.reporter_id != event.arguments.reporter_id);

    if (user.user_reports.length == 0) {
      delete user.user_reports;
      let params = {
        TableName: UserTable,
        Key: {
          user_id: "reported#users",
        },
      };
      
      let user_reports_item = await docClient.get(params).promise().then(data => data.Item);
      if (event.arguments.user_id[0] == "c") {
        user_reports_item.customers.filter(user => user.user_id != event.arguments.user_id);
      } else {
        user_reports_item.tradesmen.filter(user => user.user_id != event.arguments.user_id);
      }
      
      params = {
        TableName: UserTable,
        Item: user_reports_item
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

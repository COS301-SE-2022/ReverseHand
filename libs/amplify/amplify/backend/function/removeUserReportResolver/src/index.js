const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   
   let params = {
      TableName: UserTable,
      ReturnValues: 'ALL_NEW',
      Key: {
        user_id: event.arguments.user_id,
      },
      UpdateExpression: `set user_reports = if_not_exists(user_reports,:list)`,
      ExpressionAttributeValues: {
        ":list" : []
      },
    };
    
    const user = await docClient.update(params).promise().then((resp) => resp.Attributes);
    
    if (!user.user_reports.some((report) => report.reporter_id === event.arguments.report.reporter_id)) {
      user.user_reports.push(event.arguments.report);
    } else return event.arguments.report;
    
    params = {
      TableName: UserTable,
      Item: user
    };
    
    await docClient.put(params).promise();
    
    params = {
      TableName: UserTable,
      Key: {
        user_id: "reported#users",
      },
    };
    
    const user_reports_list = await docClient.get(params).promise().then((resp) => resp.Item);
    if (event.arguments.user_id[0] == "c") {
      if (!user_reports_list.customers.some(e => e.user_id === event.arguments.user_id)) {
        user_reports_list.customers.push({"user_id": event.arguments.user_id});
    }
    } else {
      if (!user_reports_list.tradesmen.some(e => e.user_id === event.arguments.user_id)) {
        user_reports_list.tradesmen.push({"user_id": event.arguments.user_id});
      }
    }
    
    params = {
      TableName: UserTable,
      Item: user_reports_list
    };
    
    await docClient.put(params).promise();
    
    return event.arguments.report;
};

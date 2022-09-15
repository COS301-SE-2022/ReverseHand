const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   let paramsReportsList = {
            TableName: UserTable, 
            Key: {
                user_id: "reported#reviews"
            } 
        };
        
    const reported_reviews_item = await docClient.get(paramsReportsList).promise().then((resp) => resp.Item);
    
    let user_ids = [...reported_reviews_item.customers, ...reported_reviews_item.tradesmen];
                
    let paramsGetUsers = {
        RequestItems: {},
    };
      
    paramsGetUsers.RequestItems[UserTable] = {Keys: user_ids};
    
    let users = await docClient.batchGet(paramsGetUsers).promise().then((resp) => resp.Responses.User);
    users.forEach(function(user) {
       user.id = user.user_id; 
       delete user.user_id;
    });
    return users;
};

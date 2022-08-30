const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: UserTable, 
            Key: {
                user_id: "reported#users"
            } 
        };
        
        const reported_users_item = await docClient.get(params).promise().then((resp) => resp.Item);
        let user_ids = [...reported_users_item.customers, ...reported_users_item.tradesmen];
        
        console.log(user_ids);
        
        params = {
            RequestItems: {},
        };
      
        params.RequestItems[UserTable] = {Keys: user_ids};
        
        const users = await docClient.batchGet(params).promise().then((resp) => resp.Responses.User);
        
        return users;
    } catch(e) {
        return e;
    }
};

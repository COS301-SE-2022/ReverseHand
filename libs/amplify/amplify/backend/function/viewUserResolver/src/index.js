const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
// UserTable
// this function is used to retrieve the information about a specific user
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable, 
            Key : {
                part_key: event.arguments.user_id,
                sort_key: event.arguments.user_id,
            }
        };
        let user = await docClient.get(params).promise().then(data => data.Item);
        
        user.id = user.user_id;
        delete user.user_id;
        
        return user;
    } catch(e) {
        return e;
    }
};

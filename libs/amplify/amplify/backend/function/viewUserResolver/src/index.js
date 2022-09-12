const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
// this function is used to retrieve the information about a specific user
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
        let params = {
            TableName: ReverseHandTable, 
            Key : {
                part_key: event.arguments.user_id,
                sort_key: event.arguments.user_id,
            }
        };
        let user = await docClient.get(params).promise().then(data => data.Item);
        
        if (user == undefined) {
            throw "No users found";
        }
        
        user.id = user.part_key;
        delete user.part_key;
        delete user.sort_key;
        
        return user;

};

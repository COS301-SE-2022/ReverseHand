const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;
// this function is used to retrieve the information about a specific user

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: UserTable, 
            KeyConditionExpression: "user_id = :u",
            ExpressionAttributeValues: {
                ":u": event.arguments.user_id,
            }
        };
        const data = await docClient.query(params).promise();
        let items = data["Items"];
    
        return items;
        
    } catch(e) {
        return e;
    }
};

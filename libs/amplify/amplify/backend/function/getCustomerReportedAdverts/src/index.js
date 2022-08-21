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
                ":p": event.arguments.user_id, // should be a consumers id
            }
        };
            
        let data = await docClient.query(params).promise();
        
        return data;
   } catch(e) {}
};

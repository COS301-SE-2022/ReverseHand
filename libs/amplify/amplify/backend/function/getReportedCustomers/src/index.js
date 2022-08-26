const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            Key : {
                part_key: event.arguments.scope,
                sort_key: event.arguments.city
            },
        };
        let data = await docClient.get(params).promise();
        let customer_keys = [];
        data.Item.customer_reports.forEach(function (id) {
            customer_keys.push({user_id: id});
        });
        
        params = {
            RequestItems: {
                User : {
                    Keys : customer_keys
                }
            },
        };
        data = await docClient.batchGet(params).promise();
        data.Responses.User.forEach(function (user) {
            user.id = user.user_id;
            delete user.user_id;
        });
        return data.Responses.User;
    } catch (e) {
        console.log(e);
    }
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

// get all reviews for a specific user

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let response = await docClient.query({
        TableName: ReverseHandTable,
        KeyConditionExpression: 'part_key = :reviews',
        ExpressionAttributeValues: {
            ':reviews': 'reviews#' + event.arguments.user_id
        }
    }).promise();

    return response.Items.map((el) => {
        let item = {
            id: el['sort_key'],
            ...el.review_details
        };
        el['id'] = el['sort_key'];
        
        return item;
    });
};
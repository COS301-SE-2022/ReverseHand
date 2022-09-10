const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
    
    const currentDate = new Date().getTime();
    event.arguments.review.date_created = currentDate;
    const transactParams = [
        {
            Put: {
                TableName: ReverseHandTable,
                Item: {
                    part_key: "reviews#" + event.arguments.user_id,
                    sort_key: "review#" + AWS.util.uuid.v4(),
                    review_detials: event.arguments.review
                }
            }
        },
        {
            Update: {
                UpdateExpression: "SET rating_count = rating_count + :count, rating_sum = rating_sum + :sum",
                ExpressionAttributeValues: {
                    ":sum": event.arguments.review.rating,
                    ":count": 1
                },
                Key: {
                    part_key: event.arguments.user_id,
                    sort_key: event.arguments.user_id,
                },
                TableName: ReverseHandTable,
            },
        }
    ]
    await docClient.transactWrite({
        TransactItems: transactParams
    }).promise();
};

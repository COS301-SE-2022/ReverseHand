const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
    
    const currentDate = new Date().getTime();
    event.arguments.review.date_created = currentDate;
    let putReviewItem = {
        part_key: "reviews#" + event.arguments.user_id,
        sort_key: "review#" + AWS.util.uuid.v4(),
        review_details: event.arguments.review
    };
    const transactParams = [
        {
            Put: {
                Item: putReviewItem,
                TableName: ReverseHandTable
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
    ];
    docClient.transactWrite({
        TransactItems: transactParams
    }).promise();
    
    putReviewItem.id = putReviewItem.sort_key;
    delete putReviewItem.part_key;
    delete putReviewItem.sort_key;
    
    return putReviewItem;
};

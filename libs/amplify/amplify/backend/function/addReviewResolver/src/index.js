const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const func = process.env.FUNCTION;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
    
    const date = new Date()
    const currentDate = date.getTime();
    event.arguments.review['date_created'] = currentDate;

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

    let transaction = docClient.transactWrite({
        TransactItems: transactParams
    }).promise();

    const lambda = new AWS.Lambda();
    let notification = lambda.invoke({
        FunctionName: func,
        Payload: JSON.stringify({
            userId: event.arguments.user_id,
            notification: {
                part_key: "notification#" + event.arguments.user_id,
                sort_key: date.toISOString(),
                title: "New Review",
                msg: "You have recieved a new review of " + event.arguments.review.rating + "stars",
                type: "ReviewAdded",
                timestamp: currentDate,
            }
        })
    }).promise();
    
    let item = {
        id: putReviewItem.sort_key,
        ...putReviewItem.review
    };

    await Promise.all([transaction, notification]);
    
    return item;
};

const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
      TableName: UserTable,
      Key: {
        user_id: event.arguments.user_id,
      },
    };
    const user = await docClient.get(params).promise().then((data) => data.Item);
    let user_reviews = user.reviews;
      
    let report_review = user_reviews.filter(review => review.id === event.arguments.review_id);
    user_reviews = user_reviews.filter(review => review.id !== event.arguments.review_id);

    params = {
      TableName: UserTable,
      ReturnValues: "ALL_NEW",
      Key: {
        user_id: event.arguments.user_id,
      },
      UpdateExpression: `set review_reports = list_append(if_not_exists(review_reports,:list),:report), reviews = :reviews`,
      ExpressionAttributeValues: {
        ":report": report_review,
        ":list" : [],
        ":reviews" : user_reviews
      },
    };
    
    await docClient.update(params).promise().then((data) => data.Attributes);
    
     params = {
      TableName: UserTable,
      Key : {
        user_id: "reported#reviews"
      }
    };
    
    let review_reports_list = await docClient.get(params).promise().then((data) => data.Item);
    if (event.arguments.user_id[0] == "c") {
      if (!review_reports_list.customers.some(user => user.user_id === event.arguments.user_id)) {
        review_reports_list.customers.push({user_id : event.arguments.user_id});
      }
    } else {
      if (!review_reports_list.tradesmen.some(user => user.user_id === event.arguments.user_id)) {
        review_reports_list.tradesmen.push({user_id : event.arguments.user_id});
      }
    }
    
    params = {
      TableName: UserTable,
      Item: review_reports_list
    };
    
    await docClient.put(params).promise();
    
    return report_review;
    
};

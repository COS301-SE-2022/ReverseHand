const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        ReturnValues: "ALL_OLD",
        Key: {
            part_key: 'reviews#' + event.arguments.user_id,
            sort_key: event.arguments.id
        },
    };

    //deleting the bid
    let item = await docClient.delete(params).promise().then(data => data.Attributes);

    // archiving the bid
    await docClient.put({
        TableName: ArchivedReverseHandTable,
        Item: item
    }).promise();

    item['review_details']['id'] = item['sort_key'];

    return item['review_details'];
};

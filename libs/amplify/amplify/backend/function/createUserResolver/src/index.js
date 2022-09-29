const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// Creates a new user
// Requires
/*
    id:from AWS Cognito, passed in to avoid working with layers
    location: {lat, long}
*/
// Optional
/*
    tradetypes: []
    domains:
*/
exports.handler = async (event) => {

    let createParams = {
        TableName: ReverseHandTable,
        Item: {
            part_key: event.arguments.user_id,
            sort_key: event.arguments.user_id,
            name: event.arguments.name,
            email: event.arguments.email,
            cellNo: event.arguments.cellNo,
            created: 0,
            finished: 0,
            rating_sum: 0,
            rating_count: 0,
            warnings: 0
        }
    };

    if (event.arguments.user_id[0] == "c") {
        createParams.Item.location = event.arguments.location;
    } else {
        createParams.Item.domains = event.arguments.domains;
        createParams.Item.tradetypes = event.arguments.tradetypes;
    };

    await docClient.put(createParams).promise();

    createParams.Item.id = createParams.Item.user_id;
    delete createParams.Item.user_id;
    return createParams.Item;

};

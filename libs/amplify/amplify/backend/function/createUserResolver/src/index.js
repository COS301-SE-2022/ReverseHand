const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

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
    try {
    
        let item = {
            TableName: UserTable,
            Item: {
                user_id: event.arguments.user_id,
                name: event.arguments.name,
                domains: event.arguments.domains,
                tradetypes: event.arguments.tradetypes,
                notifications: [],
                reviews: [],
                location: {
                    lat: event.arguments.lat,
                    long: event.arguments.long,
                }
            }
        };
        
        await docClient.put(item).promise();
    
        return item.Item;
    } catch(e) {
        console.log(e);
    }
    // getting current date
};
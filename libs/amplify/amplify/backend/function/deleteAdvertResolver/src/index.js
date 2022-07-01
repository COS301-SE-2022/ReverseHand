const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// deletes an advert, requires
/*
    id
*/
exports.handler = async (event) => {
    try {

    } catch(e) {
        console.log(e);
    }
    // getting current date
};

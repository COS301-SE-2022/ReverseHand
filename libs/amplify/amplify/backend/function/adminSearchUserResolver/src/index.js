const AWS = require("aws-sdk");
const UserPoolId = process.env.USERPOOLID;
const cognitoIdentity = new AWS.CognitoIdentityServiceProvider();

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {};

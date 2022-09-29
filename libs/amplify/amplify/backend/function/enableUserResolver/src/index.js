const AWS = require('aws-sdk');
const UserPoolId = process.env.USERPOOLID;
const cognitoIdentity = new AWS.CognitoIdentityServiceProvider();

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let cogParams = {
        "UserPoolId": UserPoolId,
        "Username": event.arguments.username
    };

    (event.arguments.disable) 
        ? await cognitoIdentity.adminDisableUser(cogParams).promise() 
        : await cognitoIdentity.adminEnableUser(cogParams).promise();

    return event.arguments.disable.toString();
};

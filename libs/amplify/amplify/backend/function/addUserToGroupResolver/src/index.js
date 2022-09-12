let AWS = require('aws-sdk');

exports.handler = async (event, context, callback) => {
    let cognitoIdentityServiceProvider = new AWS.CognitoIdentityServiceProvider();

    let params = {
        GroupName: event.arguments.group, //your confirmed user gets added to this group
        UserPoolId: process.env.USERPOOLID,  
        Username: event.arguments.email
    };

    await cognitoIdentityServiceProvider.adminAddUserToGroup(params).promise();
    return event.arguments.group;
};
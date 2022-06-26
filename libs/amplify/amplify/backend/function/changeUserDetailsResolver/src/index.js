// function to change user parameters

let AWS = require('aws-sdk');

// parameters are
// email
// location
// cellno

// oldPass
// newPass
// token (the access token required to change password)
exports.handler = (event) => {
    let cognitoIdentityServiceProvider = new AWS.CognitoIdentityServiceProvider();

    // for user attributes
    let attributes = [];
    if (event.arguments.email !== null)
        attributes.push({
            Name: "email",
            Value: event.arguments.email,
        });

    if (event.arguments.location !== null)
        attributes.push({
            Name: "location",
            Value: event.arguments.location,
        });

    if (event.arguments.cellno !== null)
        attributes.push({
            Name: "Phone number", // fix later
            Value: event.arguments.cellno,
        });

    let params = {
        UserPoolId: process.env.USERPOOLID,  
        Username: event.arguments.email,
        UserAttributes: attributes,
    };

    await cognitoIdentityServiceProvider.adminUpdateUserAttributes(params).promise();

    // for password
    if (event.arguments.token === null || event.arguments.oldPass === null || event.arguments.newPass === null)
        return;

    await cognitoIdentityServiceProvider.changePassword().promise({
        AccessToken: event.arguments.token,
        PreviousPassword: event.arguments.oldPass,
        ProposedPassword: event.arguments.newPass
    });
};
const AWS = require("aws-sdk");
const UserPoolId = process.env.USERPOOLID;
const cognitoIdentity = new AWS.CognitoIdentityServiceProvider();

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let email = event.arguments.email;
    let cognitoParams = {
        "Filter": "email = \"" + email + "\"",
        "UserPoolId": UserPoolId
    };
    const data = await cognitoIdentity.listUsers(cognitoParams).promise();
    let users = data.Users;

    let buildUser = function (user, prefix) {
        let userResp = {};
        userResp.enabled = user.Enabled;
        userResp.status = user.UserStatus;
        user.Attributes.forEach(function (attr) {
            switch (attr.Name) {
                case "sub":
                    userResp.id = prefix + attr.Value;
                    break;
                case "email":
                    userResp.email = attr.Value;
                    break;
            }
        });
        return userResp;
    };


    let result = [];
    let prefix = (event.arguments.group[0] == "c") ? "c#" : "t#";

    users.forEach(function (user) {
        result.push(buildUser(user, prefix));
    });

    return result;
};



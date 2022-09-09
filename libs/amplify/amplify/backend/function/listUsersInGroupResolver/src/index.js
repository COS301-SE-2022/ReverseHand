const AWS = require("aws-sdk");
const buildUser = require("./buildUser");
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let cognitoIdentityServiceProvider = new AWS.CognitoIdentityServiceProvider();

    let params = {
        "GroupName": event.arguments.group,
        "Limit": 10,
        "NextTokem" : event.arguments.nextToken,
        "UserPoolId": process.env.USERPOOLID
    };

    const response = await cognitoIdentityServiceProvider.listUsersInGroup(params).promise();
    let users = [];
    response.Users.forEach(function (user) {
        if (event.arguments.group == "customer")
            users.push(buildUser("c#", user));
        else 
            users.push(buildUser("t#", user));
    });
    let result = {};
    result.nextToken = response.NextToken;
    result.users = users;
    return result;
};


const AWS = require("aws-sdk");
const UserPoolId = process.env.USERPOOLID;
const ReverseHandTable = process.env.REVERSEHAND;
const docClient = new AWS.DynamoDB.DocumentClient();
const cognitoIdentity = new AWS.CognitoIdentityServiceProvider();

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
 
exports.handler = async (event) => {
    
    let userSub = event.arguments.user_id.slice(2);
    let cognitoParams = {
        "Filter": "sub = \"" + userSub + "\"",
        "UserPoolId": UserPoolId
    };
    const resp = await cognitoIdentity.listUsers(cognitoParams).promise().then(data => data.Users);
    
    if (resp.length == 0)
        throw "No user found";
    let cogUser = resp[0];
    
    let resultUser = {
        id: event.arguments.user_id,
        cognito_username: cogUser.Username,
        enabled: cogUser.Enabled,
    };
    
    let paramsGetUser = {
        TableName: ReverseHandTable,
        Key : {
            part_key: resultUser.id,
            sort_key: resultUser.id
        }
    };
    
    let user = await docClient.get(paramsGetUser).promise().then(data => data.Item);
    
    if (user == null || user == {}) 
        throw "No user found";
        
    resultUser.name = user.name;
    resultUser.email = user.email;
    resultUser.cell = user.cell;
    resultUser.warnings = user.warnings;
    
    return resultUser;
};

const AWS = require('aws-sdk');
const UserPoolId = process.env.USERPOOLID;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   const cognitoIdentity = new AWS.CognitoIdentityServiceProvider();
   
   let params = (event.arguments.next_token == undefined) ? {
      "GroupName": event.arguments.group,
      "UserPoolId": UserPoolId,
      "Limit": 10
   } : {
      "GroupName": event.arguments.group,
      "UserPoolId": UserPoolId,
      "NextToken": event.arguments.next_token,
      "Limit": 10
   };
   
   const data = await cognitoIdentity.listUsersInGroup(params).promise();
   let users = data.Users;
   let result = {};
   result.next_token = (data.NextToken != undefined) ? data.NextToken : null;
   
   let buildUser = function (user,prefix) {
      let userResp = {};
      userResp.enabled = user.Enabled;
      user.Attributes.forEach(function(attr) {
         switch(attr.Name) {
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
   
   
   result.users = [];
   let prefix = (event.arguments.group[0] == "c") ? "c#" : "t#";
   
   users.forEach(function(user) {
      result.users.push(buildUser(user, prefix));
   });
   
   return result;
};



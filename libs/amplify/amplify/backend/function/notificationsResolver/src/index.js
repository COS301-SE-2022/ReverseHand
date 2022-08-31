import URL from 'url';
import fetch from 'node-fetch';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ apiVersion: '2016-04-18' });
const initiateAuth = async ({ clientId, username, password }) => cognitoIdentityServiceProvider.initiateAuth({
    AuthFlow: 'USER_PASSWORD_AUTH',
    ClientId: clientId,
    AuthParameters: {
      USERNAME: username,
      PASSWORD: password,
    },
  })
  .promise();

export const handler = async (event, context, callback) => {
  const clientId = 'YOUR_COGNITO_CLIENT_ID';
  const endPoint = 'YOUR_GRAPHQL_END_POINT_URL';
  const username = 'COGNITO_USERNAME';
  const password = 'COGNITO_PASSWORD';
  const { AuthenticationResult } = await initiateAuth({
    clientId,
    username,
    password,
  });
  const accessToken = AuthenticationResult && AuthenticationResult.AccessToken;
  const postBody = {
    query: `mutation AddUser($userId: ID!, $userDetails: UserInput!) {
        addUser(userId: $userId, userDetails: $userDetails) {
            userId
            name
        }`,
    variables: {
        userId: 'userId',
        userDetails: { name: 'name' },
    },
  };

  const uri = await URL.parse(endPoint);

  const options = {
    method: 'POST',
    body: JSON.stringify(postBody),
    headers: {
      host: uri.host,
      'Content-Type': 'application/json',
      Authorization: accessToken,
    },
  };
  const response = await fetch(uri.href, options);
  const { data } = await response.json();

  const result = data && data.addUser;
  callback(null, result);
};
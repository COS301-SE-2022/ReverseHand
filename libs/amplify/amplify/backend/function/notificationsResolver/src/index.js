const URL = require('url');
const fetch = require('node-fetch');
const AWS = require("aws-sdk");
const SecretsManager = require('/opt/secretesmanager.js');

const cognitoIdentityServiceProvider = new AWS.CognitoIdentityServiceProvider({ apiVersion: '2016-04-18' });
const initiateAuth = async ({clientId, username, password }) => cognitoIdentityServiceProvider.adminInitiateAuth({
    AuthFlow: 'ADMIN_NO_SRP_AUTH', // [ADMIN_NO_SRP_AUTH, ADMIN_USER_PASSWORD_AUTH, USER_SRP_AUTH, REFRESH_TOKEN_AUTH, REFRESH_TOKEN, CUSTOM_AUTH, USER_PASSWORD_AUTH]
    UserPoolId: process.env.USERPOOLID,
    ClientId: clientId,
    AuthParameters: {
      USERNAME: username,
      PASSWORD: password,
    },
  })
  .promise();

exports.handler = async (event, context, callback) => {
  const secrets = await SecretsManager.getSecret("NotificationLoginSecrets", "eu-west-1");
  const creds = JSON.parse(secrets);

  const clientId = process.env.CLIENTID;
  const endPoint = process.env.ENDPOINT;
  const username = creds.username;
  const password = creds.password;
  
  const { AuthenticationResult } = await initiateAuth({
    clientId,
    username,
    password,
  });
  
  const accessToken = AuthenticationResult && AuthenticationResult.AccessToken;
  
  const postBody = {
    query: `query {
              viewBids(ad_id: "a#770afc30-250b-11ed-8df1-718bcfb21334") {
                id
              }
            }`,
  };

  const uri = URL.parse(endPoint);

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

  return data;
};
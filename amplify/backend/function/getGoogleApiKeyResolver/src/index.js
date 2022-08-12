const SecretsManager = require('./secretsmanager.js');

exports.handler = async (event) => {
    let apiKey = await SecretsManager.getSecret("GoogleApiKey", "eu-west-1");
    return JSON.parse(apiKey);
};
const SecretsManager = require('./secretsmanager.js');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let apiKey = await SecretsManager.getSecret("PayStackSecrets", "eu-west-1");
    return JSON.parse(apiKey);
};
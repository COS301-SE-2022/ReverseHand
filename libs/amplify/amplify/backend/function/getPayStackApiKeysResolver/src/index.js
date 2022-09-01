const SecretsManager = require('/opt/secretesmanager.js');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    const apiKey = await SecretsManager.getSecret("PayStackSecrets", "eu-west-1");
    return JSON.parse(apiKey);
};

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// just passses the user id through to let users know that they have new notifications
exports.handler = async (event) => {
    return event.arguments.user_id;
};

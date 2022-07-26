// used to notify of new messages

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    return {
        customer_id: event.arguments.customer_id,
        tradesman_id: event.arguments.tradesman_id,
        message: {
            msg: event.arguments.msg,
            sender: event.arguments.sender,
            timestamp: event.arguments.timestamp
        },
    }
};

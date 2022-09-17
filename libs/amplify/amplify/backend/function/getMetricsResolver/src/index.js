const AWS = require("aws-sdk");

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = JSON.parse(event.arguments.params);

    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

    let data = await cloudWatch.getMetricData(params).promise().then(resp => resp.MetricDataResults);
    return JSON.stringify(data);
};

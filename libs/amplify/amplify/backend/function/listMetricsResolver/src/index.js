
const AWS = require("aws-sdk");
const cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {

    let params = JSON.parse(event.arguments.params);

    let resp = await cloudWatch.listMetrics(params).promise().then(resp => resp);
    let data = resp.Metrics;

    while (resp.NextToken != undefined) {
        params.NextToken = resp.NextToken;
        resp = await cloudWatch.listMetrics(params).promise().then(resp => resp);
        data = [...data, ...resp.Metrics];
    }

    console.log("data=", data);
    return JSON.stringify(data);
};


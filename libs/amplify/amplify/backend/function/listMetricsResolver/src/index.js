
const AWS = require("aws-sdk");
const cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {

    let params = JSON.parse(event.arguments.params);

    let resp = await cloudWatch.listMetrics(params).promise().then(resp => resp);
    // let data = resp.MetricDataResults;

    // while (resp.NextToken != undefined) {
    //     params.NextToken = resp.NextToken;
    //     resp = await cloudWatch.getMetricData(params).promise();
    //     data.StatusCode = resp.MetricDataResults.StatusCode;
    //     for (var i = 0; i < data.length; i++) {
    //         data[i].Timestamps = [...data[i].Timestamps, ...resp.MetricDataResults[i].Timestamps];
    //         data[i].Values = [...data[i].Values, ...resp.MetricDataResults[i].Values];
    //     }

    // }

    console.log("resp=", resp);
    return JSON.stringify(resp);
};


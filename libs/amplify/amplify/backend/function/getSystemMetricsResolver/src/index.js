const AWS = require("aws-sdk");
AWS.config.update({ region: 'eu-west-1' });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });
    var date = new Date();
    console.log((date-7 * 24 * 60 * 60 * 1000));
    let params = {
        EndTime: new Date(date.getTime()), /* required */
        MetricName: 'ConsumedReadCapacityUnits', /* required */
        Namespace: 'AWS/DynamoDB', /* required */
        Period: '10', /* required */
        StartTime: new Date((date-7 * 24 * 60 * 60 * 1000)), /* required */
        Dimensions: [
            {
                Name: 'TableName', /* required */
                Value: 'ReverseHand' /* required */
            },
            /* more items */
        ],
        // ExtendedStatistics: [
        //   'STRING_VALUE',
        //   /* more items */
        // ],
        Statistics: [
            "Average",
            /* more items */
        ],
        Unit: "Seconds"
    };


    // return await cloudWatch.getMetricStatistics(params).promise();
}

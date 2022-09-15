

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
        let endDate = new Date();
    let startDate =  new Date(new Date().setHours(endDate.getHours() - 12)).toISOString();


    let params = {
        EndTime: endDate, /* required */
        MetricDataQueries: [ /* required */
            {
                Id: 'm1', /* required */
                MetricStat: {
                    Metric: { /* required */
                        Dimensions: [
                            {
                                Name: 'TableName', /* required */
                                Value: 'ReverseHand' /* required */
                            },
                            /* more items */
                        ],
                        MetricName: 'ConsumedReadCapacityUnits',
                        Namespace: 'AWS/DynamoDB'
                    },
                    Period: '300', /* required */
                    Stat: 'Average', /* required */
                },
                ReturnData: true
            },
            /* more items */
        ],
        StartTime: startDate, /* required */
        LabelOptions : {
            Timezone: "+0200",
        },
        MaxDatapoints: 144,
        ScanBy: "TimestampDescending"

    };



    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

    return await cloudWatch.getMetricData(params).promise();
};

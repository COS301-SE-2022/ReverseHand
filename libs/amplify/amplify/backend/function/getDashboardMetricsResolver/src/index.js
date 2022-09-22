const AWS = require('aws-sdk');
const fs = require('fs');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    // let endDate = new Date();
    // let startDate =  new Date(new Date().setHours(endDate.getHours() - 12)).toISOString();


    // let params = {
    //     EndTime: endDate, /* required */
    //     MetricDataQueries: [ /* required */
    //         {
    //             Id: 'm1', /* required */
    //             MetricStat: {
    //                 Metric: { /* required */
    //                     Dimensions: [
    //                         {
    //                             Name: 'TableName', /* required */
    //                             Value: 'ReverseHand' /* required */
    //                         },
    //                         /* more items */
    //                     ],
    //                     MetricName: 'ConsumedReadCapacityUnits',
    //                     Namespace: 'AWS/DynamoDB'
    //                 },
    //                 Period: '300', /* required */
    //                 Stat: 'Average', /* required */
    //             },
    //             ReturnData: true
    //         },
    //         /* more items */
    //     ],
    //     StartTime: startDate, /* required */
    //     LabelOptions : {
    //         Timezone: "+0200",
    //     },
    //     MaxDatapoints: 144,
    //     ScanBy: "TimestampDescending"

    // };



    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

    // return await cloudWatch.getMetricData(params).promise();
    let paramsMetricWidget = {
        "width": 600,
        "height": 395,
        "metrics": [
            ["AWS/DynamoDB", "ProvisionedWriteCapacityUnits", "TableName", "ReverseHand", { "color": "#7f7f7f" }],
            [".", "ConsumedWriteCapacityUnits", ".", ".", { "color": "#ff7f0e" }]
        ],
        "period": 300,
        "stacked": false,
        "title": "Write Capacity of ReverseHand",
        "view": "timeSeries",
        "start" : "-PT24H"
    };

    let params =
    {
        MetricWidget: JSON.stringify(paramsMetricWidget)
    };


    let response = await cloudWatch.getMetricWidgetImage(params).promise();

    // console.log(response.MetricWidgetImage);
    return Buffer.from(response.MetricWidgetImage).toString('base64');
    // return response.MetricWidgetImage;


};


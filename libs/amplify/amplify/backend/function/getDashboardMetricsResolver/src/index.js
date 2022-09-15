<<<<<<< HEAD
const AWS = require('aws-sdk');
const fs = require('fs');
=======
let AWS = require('aws-sdk');
>>>>>>> 716cbc3c435895c99c73ccd48b4f131b4382abfd

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
<<<<<<< HEAD
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
=======
    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });
>>>>>>> 716cbc3c435895c99c73ccd48b4f131b4382abfd
    let paramsMetricWidget = {
        "width": 600,
        "height": 395,
        "metrics": [
            ["AWS/DynamoDB", "ProvisionedWriteCapacityUnits", "TableName", "ReverseHand", { "color": "#7f7f7f" }],
            [".", "ConsumedWriteCapacityUnits", ".", ".", { "color": "#ff7f0e" }]
        ],
        "period": 300,
        "stacked": false,
<<<<<<< HEAD
        "title": "Write Capacity of ReverseHand",
        "view": "timeSeries",
        "start" : "-PT24H"
    };
=======
        "yAxis": {
            "left": {
                "min": 0.1,
                "max": 1
            },
            "right": {
                "min": 0
            }
        },
        "title": "CPU",
        "annotations": {
            "horizontal": [
                {
                    "color": "#ff6961",
                    "label": "Troublethresholdstart",
                    "fill": "above",
                    "value": 0.5
                }
            ],
            "vertical": [
                {
                    "visible": true,
                    "color": "#9467bd",
                    "label": "Bugfixdeployed",
                    "value": "2018-11-19T07:25:26Z",
                    "fill": "after"
                }
            ]
        },
        "view": "timeSeries"
    }
>>>>>>> 716cbc3c435895c99c73ccd48b4f131b4382abfd

    let params =
    {
        MetricWidget: JSON.stringify(paramsMetricWidget)
    };

<<<<<<< HEAD

    let response = await cloudWatch.getMetricWidgetImage(params).promise();

    // console.log(response.MetricWidgetImage);
    return Buffer.from(response.MetricWidgetImage).toString('base64');
    // return response.MetricWidgetImage;

=======
    let response = await cloudWatch.getMetricWidgetImage(params).promise();
    return response.MetricWidgetImage;
>>>>>>> 716cbc3c435895c99c73ccd48b4f131b4382abfd

};


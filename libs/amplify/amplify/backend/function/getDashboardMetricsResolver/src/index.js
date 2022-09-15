let AWS = require('aws-sdk');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });
    let paramsMetricWidget = {
        "width": 600,
        "height": 395,
        "metrics": [
            ["AWS/DynamoDB", "ProvisionedWriteCapacityUnits", "TableName", "ReverseHand", { "color": "#7f7f7f" }],
            [".", "ConsumedWriteCapacityUnits", ".", ".", { "color": "#ff7f0e" }]
        ],
        "period": 300,
        "stacked": false,
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

    let params =
    {
        MetricWidget: JSON.stringify(paramsMetricWidget)
    };

    let response = await cloudWatch.getMetricWidgetImage(params).promise();
    return response.MetricWidgetImage;

};


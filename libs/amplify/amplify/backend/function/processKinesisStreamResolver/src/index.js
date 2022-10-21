const AWS = require('aws-sdk');
const cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let payload = "";
    let payloads = [];
    event.Records.forEach(function (record) {
        // Kinesis data is base64 encoded so decode here
        payload = new Buffer.from(record.kinesis.data, 'base64').toString('ascii');
        payloads.push(JSON.parse(payload));
        console.log('Decoded payload:', JSON.parse(payload));
    });

    let params;

    payloads.forEach(async function (payload) {
        switch (payload.event_type) {
            case 'CreateAdvert':
                params = {
                    MetricData: [],
                    Namespace: "CustomEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "City",
                            Value: payload.attributes.city
                        }
                    ],
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "Job_Type",
                            Value: payload.attributes.job_type
                        }
                        
                    ],
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });
                break;
            case 'PlaceBid':
                let amount = payload.metrics.amount / 100;
                let range =
                    (amount <= 500) ?
                        "amount <= 500" :
                        (amount > 500 && amount <= 2500) ?
                            "500 < amount <= 2500" :
                            (amount > 2500 && amount <= 10000) ?
                                "2500 < amount <= 10000" :
                                (amount > 10000) ?
                                    "amount > 10000" : "N/A";

                params = {
                    MetricData: [],
                    Namespace: "CustomEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "Amount",
                            Value: range
                        },
                    ],
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "Job_Type",
                            Value: payload.attributes.job_type
                        },
                    ],
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });
                break;
            case '_session.start':
                params = {
                    MetricData: [],
                    Namespace: "SessionEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });
                break;
            case '_session.stop':
                params = {
                    MetricData: [],
                    Namespace: "SessionEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Unit: "Count",
                    Value: 1.0,
                    StorageResolution: 1
                });

            default:
            // code
        }
    });

    if (params != undefined) {
        console.log("params: ", params);
        const data = await cloudWatch.putMetricData(params).promise();
        console.log("Submitted to CloudWatch");
        console.log("data: ", data);
        return data;
    } else return null;

};

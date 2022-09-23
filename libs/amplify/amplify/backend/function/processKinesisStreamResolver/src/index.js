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

    payloads.forEach(function (payload) {
        switch (payload.event_type) {
            case 'CreateAdvert':
                params = {
                    MetricData: [],
                    Namespace: "CustomEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        (payload.attributes.province != undefined) ? {
                            Name: "Province",
                            Value: payload.attributes.province
                        } : null,
                        (payload.attributes.city != undefined) ? {
                            Name: "City",
                            Value: payload.attributes.province
                        } : null,
                    ],
                    Unit: "Count",
                    Value: 1.0
                });
                cloudWatch.putMetricData(params);
                break;
            case '_session.start':
                params = {
                    MetricData: [],
                    Namespace: "SessionEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Unit: "Count",
                    Value: 1.0
                });
                cloudWatch.putMetricData(params);
                break;
            case '_session.stop':
                params = {
                    MetricData: [],
                    Namespace: "SessionEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Unit: "Count",
                    Value: 1.0
                });
                cloudWatch.putMetricData(params);
                break;

            default:
            // code
        }
    });

};

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
                            Name: "Province",
                            Value: payload.attributes.province
                        },
                        {
                            Name: "City",
                            Value: payload.attributes.province
                        },
                    ],
                    Unit: "Count",
                    Value: 1.0
                });
                break;
            case 'PlaceBid':
                params = {
                    MetricData: [],
                    Namespace: "CustomEvents"
                };
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "Amount",
                            Value: payload.attributes.amount
                        },
                        {
                            Name: "job_type",
                            Value: payload.attributes.type
                        },
                    ],
                    Unit: "Count",
                    Value: 1.0
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
                    Value: 1.0
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
                    Value: 1.0
                });

            default:
            // code
        }
    });

    if (params != undefined) {
        console.log("params:\n" + params);
        const data = await cloudWatch.putMetricData(params).promise();
        console.log("Submitted to CloudWatch");
        console.log("data:\n" + data);
        return data;
    } else return null;

};

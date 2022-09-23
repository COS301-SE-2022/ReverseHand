const AWS = require('aws-sdk');

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

    let params = {
        MetricData: [],
        Namespace: "CustomEvents"
    };

    payloads.forEach(function (payload) {
        switch (payload.event_type) {
            case 'CreateAdvert':
                params.MetricData.push({
                    MetricName: payload.event_type,
                    Dimensions: [
                        {
                            Name: "Province",
                            Value: payload.attributes.province
                        },
                        {
                            Name: "City",
                            Value: payload.attributes.city
                        }
                    ],
                    Unit: "None",
                    Value: 1.0
                });
                break;

            default:
            // code
        }
    });

    console.log()
    const cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

    const data = await cloudWatch.putMetricData(params).promise();
    console.log(data);
    return "yay";
};

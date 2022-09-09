const AWS = require("aws-sdk");
AWS.config.update({ region: 'eu-west-1' });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let cloudWatch = new AWS.CloudWatch({ apiVersion: '2010-08-01' });

    let params = {
        'Dimensions': [
            {
                'Name': 'TableName', /* required */
                'Value': 'ReverseHand'
            },
            /* more items */
        ],
        'MetricName': 'ProvisionedWriteCapacityUnits',
        'Namespace': 'AWS/DynamoDB',
    };

    
    return await cloudWatch.listMetrics(params).promise();
}

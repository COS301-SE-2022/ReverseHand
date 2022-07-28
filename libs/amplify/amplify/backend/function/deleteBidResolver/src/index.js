const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

//Bid id and perhaps advert id necessary to delete a bid?

exports.handler = async (event) => {
    try {
        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.bid_id
            },
        };

        //get the bid
        const data = await docClient.get(params).promise();

        //delete the bid

        await docClient.delete(params).promise();

        return data['bid_details'];
        
    } catch (error) {
        console.log(error);
    }
};

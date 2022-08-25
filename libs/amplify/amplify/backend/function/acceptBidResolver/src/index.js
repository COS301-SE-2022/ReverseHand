const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// add a bid id to an adverts accepted bid
// requires customer id and advert id and shorlisted bid id
exports.handler = async (event) => {
    // adding accepted bid
    try {
        let item = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.ad_id
            },
            UpdateExpression: 'set advert_details.accepted_bid = :ab',
            ExpressionAttributeValues: {
                ':ab': event.arguments.sbid_id,
            },
        };

        await docClient.update(item).promise();
        
        // getting accepted bid
        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: event.arguments.ad_id,
                sort_key: event.arguments.sbid_id,
            }
        };

        const data = await docClient.get(params).promise();
        let sbid = data["Item"]['bid_details'];

        //adding the advert_id to the tradesman that won it
        params = {
            TableName: UserTable,
            Key: {
                user_id: data["Item"]['tradesman_id'],
            }
        };

        let userData = await docClient.get(params).promise();//get the tradesman
        let inputAd = [];
        

        inputAd.push(event.arguments.ad_id);
        let mergedList = [...userData['Item']['adverts_won'],...inputAd];//add the new advert to the tradesmans list

        //update that attribute in the database
        let args = [];
        let expressionAttributeNames = [];

        args.push('#adverts_won = :adverts_won');
        expressionAttributeNames['#adverts_won'] = 'adverts_won';

        let updateExpression = 'set ';

        for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
        let expressionAttributeValues = {};
        expressionAttributeValues[':adverts_won'] = mergedList;

        params = {
            TableName: UserTable,
            Key: {
                user_id: data["Item"]['tradesman_id'],
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        };
    
        await docClient.update(params).promise();

        sbid['tradesman_id'] = data["Item"]['tradesman_id'];
    
        return sbid;
    } catch(e) {
        console.log(e)
        return e;
    }
};

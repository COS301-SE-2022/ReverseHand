const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;
const ChatSentimentsIndex = process.env.CHATSENTIMENTS;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// gets the sentiments for all the chats
exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        IndexName: ChatSentimentsIndex,
        KeyConditionExpression: "sentiments = :s",
        ExpressionAttributeValues: {
            ":s": "sentiments",
        }
    }

    let tableData = docClient.query(params).promise();
    
    params.TableName = ArchivedReverseHandTable;
    let archievedTableData = docClient.query(params).promise();

    let data = await tableData;
    let items = data.Items;

    data = await archievedTableData;
    items = [...items, ...data.Items];

    return items.map((el) => {
        el['sentiment'] = {...el};
        el['id'] = el['sort_key'];
        return el;
    });
};

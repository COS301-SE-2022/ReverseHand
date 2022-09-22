const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

// archives a caht by recieving the advert, consumer and tradesman id's
/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let data = await docClient.query({
        TableName: ReverseHandTable,
        KeyConditionExpression: "part_key = :a", // filtering by bids
        ExpressionAttributeValues: {
            ":a": "chat#"+ event.arguments.ad_id,
        }
    }).promise();

    let items = data["Items"];
    let params = {};
    let opps = {};
    opps[ReverseHandTable] = [];
    opps[ArchivedReverseHandTable] = [];
    params.RequestItems = opps;

    if (items.length != 0) {
        opps[ReverseHandTable] = [
            ...items.map(item => ({
                DeleteRequest: {
                    Key: {
                        part_key: item.part_key,
                        sort_key: item.sort_key,
                    }
                }
            }))
        ];

        opps[ArchivedReverseHandTable] = [
            ...items.map(item => ({
                PutRequest: {
                    Item: item
                }
            })) 
        ];

        // deleting bids
        params = {
            RequestItems: {}
        };

        params.RequestItems = opps;
    }

    // getting root items
    let chats = {};
    chats[ReverseHandTable] = {
        Keys: [
            {
                part_key: "chats#" + event.arguments.c_id,
                sort_key: "chat#" + event.arguments.ad_id,
            },
            {
                part_key: "chats#" + event.arguments.t_id,
                sort_key: "chat#" + event.arguments.ad_id,
            }
        ]
    };

    chats = await docClient.batchGet({
        RequestItems: chats,
    }).promise();
    
    let chatItems = chats['Responses'][ReverseHandTable];

    // deleting root items
    params["RequestItems"][ReverseHandTable].push({
        DeleteRequest: {
            Key: {
                part_key: "chats#" + event.arguments.c_id,
                sort_key: "chat#" + event.arguments.ad_id,
            }
        }
    });
    params["RequestItems"][ReverseHandTable].push({
        DeleteRequest: {
            Key: {
                part_key: "chats#" + event.arguments.t_id,
                sort_key: "chat#" + event.arguments.ad_id,
            }
        }
    });

    // adding root items
    params["RequestItems"][ArchivedReverseHandTable].push({
        PutRequest: {
            Item: chatItems[0]
        }
    });
    params["RequestItems"][ArchivedReverseHandTable].push({
        PutRequest: {
            Item: chatItems[1]
        }
    });

    await docClient.batchWrite(params).promise();

    return chatItems[0];
};

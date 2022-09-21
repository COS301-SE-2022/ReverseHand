const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    
    let paramsDeleteAdvert = {
        TableName: ReverseHandTable,
        ReturnValues: "ALL_OLD",
        Key: {
          part_key: event.arguments.advert_id,
          sort_key: event.arguments.advert_id
        }
    };

    let advert = await docClient.delete(paramsDeleteAdvert).promise().then((resp) => resp.Attributes);
  
    let paramsArchiveAdvert = {
        TableName: ArchivedReverseHandTable,
        Item: advert
    };
    
    console.log(advert);

    await docClient.put(paramsArchiveAdvert).promise();
    let domain = advert.advert_details.domain.city + "#" + advert.advert_details.domain.province;
    let type = advert.advert_details.type;

    let paramsGetAdvertsList = {
        TableName: ReverseHandTable,
        ReturnValues: "ALL_OLD",
        Key: {
            part_key: advert.advert_details.domain.city + "#" + advert.advert_details.domain.province,
            sort_key: advert.advert_details.type
        }
    };

    let batch_lists = await docClient.delete(paramsGetAdvertsList).promise().then(data=>data.Attributes);
    
    if (batch_lists.reports_list !== undefined) {
        batch_lists.reports_list = batch_lists.reports_list.filter(key => key.part_key != advert.part_key);    
        if (batch_lists.reports_list.length === 0) delete batch_lists.reports_list;
    }
    
    if (batch_lists.advert_list !== undefined) {
        batch_lists.advert_list = batch_lists.advert_list.filter(key => key.part_key != advert.part_key);
        if (batch_lists.advert_list.length === 0) delete batch_lists.advert_list;
    }
    
    if(batch_lists.reports_list !== undefined || batch_lists.advert_list !== undefined) {
        let paramsPutReportsList = {
            TableName: ReverseHandTable,
            Item: batch_lists
        };

        await docClient.put(paramsPutReportsList).promise();

    }

    
    if (event.arguments.issueWarning) {
        let paramsUpdateUser = {
          TableName: ReverseHandTable,
          Key: {
            part_key: advert.customer_id,
            sort_key: advert.customer_id
          },
          UpdateExpression: `set warnings = warnings + :count`,
          ExpressionAttributeValues: {
            ":count": 1
          },
        };
    
        await docClient.update(paramsUpdateUser).promise();
    
      }

    
    advert.advert_details.id = advert.part_key;
    advert.advert_details.customer_id = advert.customer_id;
    return advert.advert_details;

};

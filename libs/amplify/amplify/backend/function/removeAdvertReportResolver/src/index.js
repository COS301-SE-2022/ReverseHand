const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

//This function is to remove a report from a reportedAdvert
//Thereafter it checks to see if the advert has any reports, else it can be removed
//Thereafter it checks to see if the customer can be removed from the geo specific report list

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    let params = {
        TableName: ReverseHandTable,
        Key: {
            part_key: event.arguments.advert_id,
            sort_key: event.arguments.advert_id
        }
    };
    
    let data = await docClient.get(params).promise();
    let reported_advert = data.Item;
    console.log("reported_ad");
    console.log(reported_advert);
    //filter out report by tradesman_id
    reported_advert.admin_reports = reported_advert.admin_reports.filter(report => report.tradesman_id != event.arguments.tradesman_id);
    reported_advert.count = reported_advert.admin_reports.length;
    
    //if the advert has no other reports, delete the admin_reports obj & the id 
    //so it doesn't show up in the admin_customer_view GSI
    if (reported_advert.admin_reports.length == 0) { //this should be 0 if i forgot to change it
        delete reported_advert.admin_reports;
        delete reported_advert.report_id;
        
        //read all the advert reports for the customer whose advert reports was just deleted
        params = {
        TableName: ReverseHandTable,
            IndexName: "admin_customer_view",
            KeyConditionExpression: "customer_id = :p",
            ExpressionAttributeValues: {
                ":p": reported_advert.customer_id, // should be a consumers id
            }
        };
        
        let data = await docClient.query(params).promise();
        let adverts = data.Items;
        //filter the reported adverts on if other reported advert exist in the same domain as the one that was deleted
        adverts = adverts.filter(advert =>
            (advert.advert_details.domain.city == reported_advert.advert_details.domain.city && 
             advert.advert_details.domain.province == reported_advert.advert_details.domain.province) 
        );
             
        // if there are no adverts in the same domain, we must remove the customer id from the geolist
        if (adverts.length == 0) {
            //fetch geolist for reported advert
            let params = {
                TableName: ReverseHandTable,
                Key : {
                    part_key: reported_advert.advert_details.domain.province,
                    sort_key: reported_advert.advert_details.domain.city
                }
            };
            
            let data = await docClient.get(params).promise();
            let geo_list = data.Item;
            //add id's who aren't current customer id
            geo_list.customer_reports = geo_list.customer_reports.filter(id => id != reported_advert.customer_id);
            params = {
                TableName: ReverseHandTable,
                Item: geo_list,
            };
            await docClient.put(params).promise();
        }
    }
    
    //write the updated advert back to the table
    params = {
        TableName: ReverseHandTable,
        Item: reported_advert,
    };
    
    await docClient.put(params).promise();
    reported_advert.advert_details.id = reported_advert.part_key;
    return reported_advert;
};

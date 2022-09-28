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
    
    let reported_advert = await docClient.get(params).promise().then((resp) => resp.Item);

    //filter out report by tradesman_id
    reported_advert.admin_reports = reported_advert.admin_reports.filter(report => report.reporter_user.id != event.arguments.tradesman_id);
    // console.log(reported_advert.admin_reports)
    //if the advert has no other reports, delete the admin_reports obj & the id 
    //so it doesn't show up in the admin_customer_view GSI
    if (reported_advert.admin_reports.length == 0) { //this should be 0 if i forgot to change it
        delete reported_advert.admin_reports;
        delete reported_advert.report_id;
        
        //remove advert from advert reports list
        let params = {
            TableName: ReverseHandTable,
            Key: {
                part_key: reported_advert.advert_details.domain.city + "#" + reported_advert.advert_details.domain.province,
                sort_key: reported_advert.advert_details.type
            }
        };
        let reports = await docClient.get(params).promise().then((resp) => resp.Item);
        reports.reports_list = reports.reports_list.filter(advert => advert.part_key != reported_advert.part_key);
        //if no other reports, delete the reports
        if (reports.reports_list.length == 0) {
            delete reports.reports_list;
        }
        params = {
            TableName: ReverseHandTable,
            Item: reports
        };
        
        await docClient.put(params).promise();
        
        
    }
    
    //write updated advert back to db.
    params = {
            TableName: ReverseHandTable,
            Item: reported_advert
        };
        
    await docClient.put(params).promise();
    
    reported_advert.advert_details.id = reported_advert.part_key;
    return reported_advert;
};

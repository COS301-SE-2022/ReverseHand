const AWS = require("aws-sdk");
require('dotenv').config();

const createAdvertEvent = {
    arguments: {
        customer_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
        title: "Lambda Test Hundred",
        description: "This is a test description",
        domain :{
            city: "Pretoria",
            province: "Gauteng",
            coordinates : {
                lng: 28.2625799,
                lat: -25.7670289
            }
        },
        type: "Plumbing",
        images: 0
    }
};

jest.setTimeout(70000000);

describe("Integration Test: CloseAdvertResolver", ()=>{
    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand';
        process.env.FUNCTION = "arn:aws:lambda:eu-west-1:727515863527:function:notificationsResolver-staging";
        process.env.ARCHIVEDREVERSEHAND = "ArchivedReverseHand";


        AWS.config.update({
            region: process.env.REGION,
            credentials: {
                accessKeyId: process.env.AWS_ACCESS_KEY_ID,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
            }
        });
    });

    //variables to be used in differnt parts of tests
    var adId = "";

    test("Testing closing of an advert", async ()=>{
         //create an advert
         var handlerModule = require('../amplify/backend/function/createAdvertResolver/src/index');
         var result = await handlerModule.handler(createAdvertEvent);
 
         expect(result.title).toEqual('Lambda Test Hundred');
         expect(result.description).toEqual('This is a test description');
         expect(result.type).toEqual('Plumbing');
         adId = result.id;

        //************************************************************************************************** */
        //Add Advert Report Resolver
        console.log("Testing adding Report to advert");

        addReportEvent = {
            arguments : {
                advert_id : adId,
                report : {
                    id : "Report #1",
                    reportType : "harassment",
                    report_details : {
                        reporter_user : {
                            id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                            name : "Alexander"
                        },
                        reported_user : {
                            id : 't#acff077a-8855-4165-be78-090fda375f90',
                            name : "Richard"
                        },
                        reason : "He said some mean words",
                        description : "That guy needs help"
                    },
                    review_details : {
                        id : "Review #1",
                        rating : 0,
                        description : "Some description",
                        advert_id : adId
                    }
                }
            }
        };

        handlerModule = require('../amplify/backend/function/addAdvertReportResolver/src/index');
        result = await handlerModule.handler(addReportEvent);

        expect(result.reports.length).toBeGreaterThanOrEqual(1);

        //************************************************************************************************** */
        //removeAdvertReport resolver
        console.log("Remove Advert Report");

        const removeReportEvent = {
            arguments : {
                tradesman_id : 't#acff077a-8855-4165-be78-090fda375f90',
                advert_id : adId
            }
        };

        handlerModule = require('../amplify/backend/function/removeAdvertReportResolver/src/index');
        result = await handlerModule.handler(removeReportEvent);

        const r = result.admin_reports[0].id;

        expect(r).toEqual("Report #1");//verify that the correct report is removed
        //************************************************************************************************** */
        //closing the advert

        const closeAdvertEvent = {
            arguments : {
                ad_id : adId
            }
        };

        handlerModule = require('../amplify/backend/function/closeAdvertResolver/src/index');
        result = await handlerModule.handler(closeAdvertEvent);

        //get todays date
        const date = new Date();
        const dd = String(date.getDate()).padStart(2, '0');
        const mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
        const yyyy = date.getFullYear();
        const currentDate = mm + '-' + dd + '-' + yyyy;

        //verify the closed field of advert has a value
        expect(result.date_closed).toEqual(currentDate);

        //********************************************************************************************* */
        


        //********************************************************************************************* */
        //deleteAdvertResolver

        const deleteAdvertEvent = {
            arguments : {
                ad_id : adId
            }
        };

        console.log("Testring deletion of advert");


        handlerModule = require('../amplify/backend/function/deleteAdvertResolver/src/index');
        result = await handlerModule.handler(deleteAdvertEvent);

        //check if the returned advert is the one we expect to delete
        expect(result.title).toEqual("Lambda Test Hundred");
    });
});
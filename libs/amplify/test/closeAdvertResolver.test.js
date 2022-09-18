const AWS = require("aws-sdk");
require('dotenv').config();

const createAdvertEvent = {
    arguments: {
        customer_id : "c#fbf7af5d-4820-4b36-a90c-53cad977a702",
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
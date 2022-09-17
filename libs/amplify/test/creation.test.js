const AWS = require("aws-sdk");
require('dotenv').config();

const createAdvertEvent = {
    arguments: {
        customer_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd",
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

const viewAdvertEvent = {
    arguments : {
        user_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd"
    }
};

jest.setTimeout(70000000);




describe("Creation of Adverts, Bids, and deletion tests",  () =>{
    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand';
        process.env.FUNCTION = "arn:aws:lambda:eu-west-1:727515863527:function:notificationsResolver-staging";

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
    var bidId = "";

    test("Testing creation, deletion and bid operations", async () =>{

        //create an advert
        var handlerModule = require('../amplify/backend/function/createAdvertResolver/src/index');
        var result = await handlerModule.handler(createAdvertEvent);

        expect(result.title).toEqual('Lambda Test Hundred');
        expect(result.description).toEqual('This is a test description');
        expect(result.type).toEqual('Plumbing');
        adId = result.id;

        //********************************************************************************************* */

        //placing a bid on an advert
        console.log("Testing placing a bid on an advert");
        
        const placeBidEvent = {
            arguments : {
                ad_id : adId,
                tradesman_id : 't#acff077a-8855-4165-be78-090fda375f90',
                name : 'Alexander',
                price_lower : 500,
                price_upper : 1200,
                quote : null,
            }
        };

        handlerModule = require('../amplify/backend/function/placeBidResolver/src/index');
        result = await handlerModule.handler(placeBidEvent);

        expect(result.name).toEqual('Alexander');
        expect(result.price_lower).toEqual(500);
        expect(result.price_upper).toEqual(1200);
        expect(result.shortlisted).toEqual(false);

        bidId = result.id;

        //********************************************************************************************* */
        //shortlisting a bid

        const shortListBidEvent = {
            arguments : {
                ad_id : adId,
                bid_id : bidId,
                tradesman_id : "t#acff077a-8855-4165-be78-090fda375f90"
            }
        };
        
        console.log("Testing shortListing a bid");

        handlerModule = require('../amplify/backend/function/shortListBidResolver/src/index');
        result = await handlerModule.handler(shortListBidEvent);

        expect(result.shortlisted).toEqual(true);
        expect(result.name).toEqual('Alexander');

        //********************************************************************************************* */


        console.log("Testing to see if adverrt was indeed created");

        handlerModule = require('../amplify/backend/function/viewAdvertsResolver/src/index');
        result = await handlerModule.handler(viewAdvertEvent);

        var val = result.find(element => element.title == "Lambda Test Hundred");
        
        expect(val.title).toEqual("Lambda Test Hundred");

        const viewBidsEvent = {
            arguments : {
                ad_id : adId
            }
        };

        //********************************************************************************************* */

        console.log("Test to see if bid was created");

        handlerModule = require('../amplify/backend/function/viewBidsResolver/src/index');
        result = await handlerModule.handler(viewBidsEvent);

        val = result.find(element => element.name == "Alexander");

        expect(val.name).toEqual("Alexander");
        expect(val.price_lower).toEqual(500);
        expect(val.price_upper).toEqual(1200);

        //Second last step: delete a bid
        const deleteBidEvent = {
            arguments : {
                ad_id : adId,
                bid_id : bidId
            }
        };

        //********************************************************************************************* */

        console.log("Testing the deletion of a bid");
        handlerModule = require('../amplify/backend/function/deleteBidResolver/src/index');
        result = await handlerModule.handler(deleteBidEvent);

        //check to see if the bid that was returned is the deleted one
        expect(val.name).toEqual("Alexander");
        expect(val.price_lower).toEqual(500);
        expect(val.price_upper).toEqual(1200);

        const deleteAdvertEvent = {
            arguments : {
                ad_id : adId
            }
        };

        //********************************************************************************************* */

        console.log("Testring deletion of advert");


        handlerModule = require('../amplify/backend/function/deleteAdvertResolver/src/index');
        result = await handlerModule.handler(deleteAdvertEvent);

        //check if the returned advert is the one we expect to delete
        expect(result.title).toEqual("Lambda Test Hundred");

    });
});
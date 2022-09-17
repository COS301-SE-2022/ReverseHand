const AWS = require("aws-sdk");
require('dotenv').config();

const createAdvertEvent = {
    arguments: {
        customer_id : "c#fbf7af5d-4820-4b36-a90c-53cad977a702",
        title: "Lambda Test Hundred One",
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

describe("Editing Bids and Adverts Integration Test", ()=>{
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
    var bidId = "";

    test("Editing Stuff", async ()=>{

        //create an advert
        var handlerModule = require('../amplify/backend/function/createAdvertResolver/src/index');
        var result = await handlerModule.handler(createAdvertEvent);

        expect(result.title).toEqual('Lambda Test Hundred One');
        expect(result.description).toEqual('This is a test description');
        expect(result.type).toEqual('Plumbing');
        adId = result.id;

        //********************************************************************************************* */
        //edit the advert now
        const editAdvertEvent = {
            arguments: {
                ad_id : adId,
                title : "Lambda Test Two Hundred One",
                type : "Painting",
                description : "This is a second test description"
            }
        };

        console.log("Changing Details of existing Advert");

        handlerModule = require('../amplify/backend/function/editAdvertResolver/src/index');
        result = await handlerModule.handler(editAdvertEvent);

        expect(result.title).toEqual('Lambda Test Two Hundred One');
        expect(result.description).toEqual('This is a second test description');
        expect(result.type).toEqual('Painting');

        //********************************************************************************************* */

        //placing a bid on an advert
        console.log("Testing placing a bid on an advert");
        
        const placeBidEvent = {
            arguments : {
                ad_id : adId,
                tradesman_id : 't#acff077a-8855-4165-be78-090fda375f90',
                name : 'Alexander',
                price : 500,
                quote : null,
            }
        };

        handlerModule = require('../amplify/backend/function/placeBidResolver/src/index');
        result = await handlerModule.handler(placeBidEvent);

        expect(result.name).toEqual('Alexander');
        expect(result.price).toEqual(500);
        expect(result.shortlisted).toEqual(false);

        bidId = result.id;
        

        //******************************************************************************************************* */
        //edit bid
        const editBidEvent = {
            arguments : {
                quote: null,
                price: 100,
                ad_id : adId,
                bid_id : bidId
            }
        }

        console.log("Editing a bid");

        handlerModule = require('../amplify/backend/function/editBidResolver/src/index');
        result = await handlerModule.handler(editBidEvent);

        expect(result.price).toEqual(100);


        //********************************************************************************************* */

        const deleteBidEvent = {
            arguments : {
                ad_id : adId,
                bid_id : bidId
            }
        };

       console.log("Testing the deletion of a bid");
        handlerModule = require('../amplify/backend/function/deleteBidResolver/src/index');
        result = await handlerModule.handler(deleteBidEvent);

        //check to see if the bid that was returned is the deleted one
        expect(result.name).toEqual("Alexander");
        expect(result.price).toEqual(100);

        //********************************************************************************************* */
        //deleting advert
        
        const deleteAdvertEvent = {
            arguments : {
                ad_id : adId
            }
        };
        console.log("Testring deletion of advert");


        handlerModule = require('../amplify/backend/function/deleteAdvertResolver/src/index');
        result = await handlerModule.handler(deleteAdvertEvent);

        //check if the returned advert is the one we expect to delete
        expect(result.title).toEqual("Lambda Test Two Hundred One");

    });
});
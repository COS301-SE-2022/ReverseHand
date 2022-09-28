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

describe("Get Bids On Advert integration test", ()=>{
    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand';
        process.env.ReverseHandTable = 'ReverseHand';
        process.env.FUNCTION = "arn:aws:lambda:eu-west-1:727515863527:function:notificationsResolver-staging";
        process.env.ARCHIVEDREVERSEHAND = "ArchivedReverseHand";
        process.env.TRADESMAN = "tradesman_view";


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
    var bidIdTwo = "";

    test("Getting Bids on Adverts", async ()=>{
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

        //placing a second bid

        const placeBidEventTwo = {
            arguments : {
                ad_id : adId,
                tradesman_id : 't#acff077a-8855-4165-be78-090fda375f90',
                name : 'Alexander',
                price : 400,
                quote : null,
            }
        }

        handlerModule = require('../amplify/backend/function/placeBidResolver/src/index');
        result = await handlerModule.handler(placeBidEventTwo);

        expect(result.price).toEqual(400);

        bidIdTwo = result.id;

        //********************************************************************************************* */
        //getBidsOnAdvert resolver
        console.log("Testing getBidOnAdvertsResolver");

        const getBidsEvent = {
            arguments : {
                tradesman_id : "t#acff077a-8855-4165-be78-090fda375f90"
            }
        }

        handlerModule = require('../amplify/backend/function/getBidOnAdvertsResolver/src/index');
        result = await handlerModule.handler(getBidsEvent);

        expect(result.length).toBeGreaterThanOrEqual(2);//since we place 2 bids guaranteed


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


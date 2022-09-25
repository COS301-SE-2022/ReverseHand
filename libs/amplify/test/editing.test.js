const AWS = require("aws-sdk");
require('dotenv').config();

const createAdvertEvent = {
    arguments: {
        customer_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
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
    var reviewId = "";//this is for review. acquired from addReviewResolver

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
        //deleting Bid
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
        //adding a Review to the advert

        console.log("Testing Adding Review To user");

        const addReviewEvent = {
            arguments : {
                user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                review : {
                    id : "#ID12345",
                    rating : 5,
                    description : "Integration Tests",
                    user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                    advert_id : adId,
                    date_created : 12324345
                }
            }
        };

        handlerModule = require('../amplify/backend/function/addReviewResolver/src/index');
        result = await handlerModule.handler(addReviewEvent);


        expect(result.id).not.toBe(null);
        reviewId = result.id;

        //********************************************************************************************* */
        //getUserReviews Resolver

        console.log("getUserReviews test");
        const getUserReviewsEvent = {
            arguments : {
                user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5"
            }
        };

        handlerModule = require('../amplify/backend/function/getUserReviewsResolver/src/index');
        result = await handlerModule.handler(getUserReviewsEvent);

        expect(result.length).toBeGreaterThanOrEqual(1);//there should be at least one review
        //********************************************************************************************* */
        //Deleting a review
        /*console.log("Deleting a Review");
        const deleteReviewEvent = {
            arguments : {
                user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                id : reviewId
            }
        };

        handlerModule = require('../amplify/backend/function/deleteReviewResolver/src/index');
        result = await handlerModule.handler(deleteReviewEvent);

        console.log(result);
        //need to complete deleting a review. THe resolver needs fixing/updating*/

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
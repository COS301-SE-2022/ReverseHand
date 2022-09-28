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

const viewAdvertEvent = {
    arguments : {
        user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5"
    }
};

jest.setTimeout(70000000);




describe("Creation of Adverts, Bids, and deletion tests",  () =>{
    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand';
        process.env.ReverseHandTable = 'ReverseHand';
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
    var chatId = "";

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
        //viewAdvertResolver

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
        //viewBidResolver
        console.log("Test to see if bid was created");

        handlerModule = require('../amplify/backend/function/viewBidsResolver/src/index');
        result = await handlerModule.handler(viewBidsEvent);

        val = result.find(element => element.name == "Alexander");

        expect(val.name).toEqual("Alexander");
        expect(val.price).toEqual(500);

        //********************************************************************************************* */
        //AcceptBidResolvver
        console.log("Testing Accepting a bid");

        const acceptBidEvent = {
            arguments :{
                sbid_id : bidId,
                ad_id : adId
            }
        };

        handlerModule = require('../amplify/backend/function/acceptBidResolver/src/index');
        result = await handlerModule.handler(acceptBidEvent);

        expect(result.name).toEqual("Alexander");//verify that the bid returned is indeed the right one
        expect(result.tradesman_id).toEqual("t#acff077a-8855-4165-be78-090fda375f90");
       

        //********************************************************************************************* */
        //createChat resolver
        console.log("createChat integration test");

        const createChatEvent = {
            arguments : {
                c_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                c_name : 'Alexander',
                t_id : "t#acff077a-8855-4165-be78-090fda375f90",
                t_name : 'Richard',
                ad_id: adId
            }
        };

        handlerModule = require('../amplify/backend/function/createChatResolver/src/index');
        result = await handlerModule.handler(createChatEvent);

        chatId = result.id;
        expect(result.consumer_name).toEqual("Alexander");//verify from what was returned that the chat was created
        expect(result.tradesman_name).toEqual('Richard');

        //********************************************************************************************* */
        //sendMessageResolver

        console.log("Testing sending a message");

        const sendMessageEvent = {
            arguments : {
                chat_id : chatId,
                sender : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
                msg : "Hey There!"
            }
        };

        handlerModule = require('../amplify/backend/function/sendMessageResolver/src/index');
        result = await handlerModule.handler(sendMessageEvent);

        //verify response
        expect(result.msg).toEqual('Hey There!');


        //********************************************************************************************* */
        //getMessageResolver

        console.log("Testing getMessage Resolver");
        const getMessageEvent = {
            arguments : {
                chat_id : chatId
            }
        };
        handlerModule = require('../amplify/backend/function/getMessagesResolver/src/index');
        result = await handlerModule.handler(getMessageEvent);

        expect(result.length).toBeGreaterThanOrEqual(1);

        //********************************************************************************************* */
        //getChatsResolver
        console.log('Get Chats Resolver');

        const getChatsEvent = {
            arguments : {
                user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5"
            }
        };

        handlerModule = require('../amplify/backend/function/getChatsResolver/src/index');
        result = await handlerModule.handler(getChatsEvent);

        var foundChat = false;

        for(const element of result){
            if(element.tradesman_name === 'Richard' && element.consumer_name === 'Alexander'){
                foundChat = true;
            }
        };

        expect(foundChat).toEqual(true);

        //********************************************************************************************* */
        //getNotificationsResolver
        console.log("getNotifications test");

        const getNotificationEvent = {
            arguments : {
                user_id :  "t#acff077a-8855-4165-be78-090fda375f90"
            }
        };

        handlerModule = require('../amplify/backend/function/getNotificationsResolver/src/index');
        result = await handlerModule.handler(getNotificationEvent);

        expect(result.length).toBeGreaterThanOrEqual(1);//one notification to tradesman about their bid being shortlisted

        //********************************************************************************************* */
        /*//deleteChat resolver
        console.log("delete chat integration test");
        console.log(adId);
        const deleteChatEvent = {
            arguments : {
                ad_id : adId,
                c_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5"
            }
        };

        handlerModule = require('../amplify/backend/function/deleteChatResolver/src/index');
        result = await handlerModule.handler(deleteChatEvent);

        console.log(result);*/

        //********************************************************************************************* */
        //DeleteBid Resolver
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
        expect(result.price).toEqual(500);

        
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
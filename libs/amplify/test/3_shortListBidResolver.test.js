const AWS = require("aws-sdk");
require('dotenv').config();

const event = {
    arguments : {
        ad_id : "a#6ac1daf9-45a0-49c3-8a80-be34f1b2babe",
        bid_id : "b#e17bc9a4-f48a-4ae7-abb6-32075e45af16",
        tradesman_id : "t#acff077a-8855-4165-be78-090fda375f90"
    }
};

jest.setTimeout(1000000);

describe("ShortList Bid Integration Test", ()=>{
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

    test("Check that Bid is ShortListed", async ()=>{
        const handlerModule = require('../amplify/backend/function/shortListBidResolver/src/index');
        const result = await handlerModule.handler(event);

        console.log(result);
        expect(result.shortlisted).toEqual(true);
        expect(result.name).toEqual('Alexander');
    })
});

/*
    * Temporary Data to be deleted later
{
      name: 'Alexander',
      price_lower: 500,
      price_upper: 1200,
      quote: null,
      date_created: 1663325817363,
      date_closed: undefined,
      shortlisted: true,
      tradesman_id: 't#acff077a-8855-4165-be78-090fda375f90',
      id: 'b#e17bc9a4-f48a-4ae7-abb6-32075e45af16'
    }

*/
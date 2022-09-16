const AWS = require("aws-sdk");
require('dotenv').config();

const event = {
    arguments : {
        ad_id : "a#6ac1daf9-45a0-49c3-8a80-be34f1b2babe",
        tradesman_id : 't#acff077a-8855-4165-be78-090fda375f90',
        name : 'Alexander',
        price_lower : 500,
        price_upper : 1200,
        quote : null,
    }
};

jest.setTimeout(1000000);

describe("Place Bid Resolver Integration Test", ()=>{
    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand'; 
        AWS.config.update({
            region: process.env.REGION,
            credentials: {
                accessKeyId: process.env.AWS_ACCESS_KEY_ID,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
            }
        });
    });

    test("Checking bid_details", async ()=>{
        const handlerModule = require('../amplify/backend/function/placeBidResolver/src/index');
        const result = await handlerModule.handler(event);

        expect(result.name).toEqual('Alexander');
        expect(result.price_lower).toEqual(500);
        expect(result.price_upper).toEqual(1200);
        expect(result.shortlisted).toEqual(false);
    });
});

/**
 
    *Temporary: to be deleted later
{
      name: 'Alexander',
      price_lower: 500,
      price_upper: 1200,
      quote: null,
      date_created: 1663325817363,
      shortlisted: false,
      id: 'b#e17bc9a4-f48a-4ae7-abb6-32075e45af16',
      tradesman_id: 't#acff077a-8855-4165-be78-090fda375f90'
    }
 
 */
const AWS = require("aws-sdk");
require('dotenv').config();


const event = {
    arguments : {
        quote: null,
        price_lower: 100,
        price_upper: 400,
        ad_id : "a#6ac1daf9-45a0-49c3-8a80-be34f1b2babe",
        bid_id : 'b#e17bc9a4-f48a-4ae7-abb6-32075e45af16'
    }
};

jest.setTimeout(100000);

describe("EditBidResolver Integration Test", ()=>{
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

    test("Testing to see if details are changed Correctly", async ()=>{
        const handlerModule = require('../amplify/backend/function/editBidResolver/src/index');
        const result = await handlerModule.handler(event);

        console.log(result);

        expect(result.price_lower).toEqual(100);
        expect(result.price_upper).toEqual(400);
        
    });
});
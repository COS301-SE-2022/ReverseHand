const AWS = require('aws-sdk');
require('dotenv').config();

const event = {
    arguments : {
        ad_id : "a#6ac1daf9-45a0-49c3-8a80-be34f1b2babe"
    }
};

jest.setTimeout(1000000);

describe("viewBids Integration Test", ()=>{
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

    test("CHeck to see if placed bid exists", async ()=>{
        const handlerModule = require('../amplify/backend/function/viewBidsResolver/src/index');
        const result = await handlerModule.handler(event);

        const val = result.find(element => element.name == "Alexander");

        expect(val.name).toEqual("Alexander");
        expect(val.price_lower).toEqual(500);
        expect(val.price_upper).toEqual(1200);
        
    });
});



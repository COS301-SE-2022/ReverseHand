const AWS = require('aws-sdk');
require('dotenv').config();

const event = {
    arguments : {
        user_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd"
    }
};

jest.setTimeout(1000000);

describe("ViewAdverts Integration Test", ()=>{
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

    test("CHeck to see if you can find created advert", async ()=>{
        const handlerModule = require('../amplify/backend/function/viewAdvertsResolver/src/index');
        const result = await handlerModule.handler(event);

        const val = result.find(element => element.title == "Lambda Test One");
        
        expect(val.title).toEqual("Lambda Test One");
    });
});
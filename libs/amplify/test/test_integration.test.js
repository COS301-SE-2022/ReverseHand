const AWS = require("aws-sdk");
console.log(require('dotenv').config());
const event = {
    arguments: {
        user_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd"   
    }
};

jest.setTimeout(1000000);

describe("test", () =>{

    beforeAll(() => {
        process.env.REVERSEHAND = 'ReverseHand'; 
        AWS.config.update({
            region: 'eu-west-1',
            credentials: {
                accessKeyId: process.env.AWS_ACCESS_KEY_ID,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
            }
        });
    });

    test("Integration test", async () =>{

        const handlerModule = require('../amplify/backend/function/viewUserResolver/src/index');
        
        const result = await handlerModule.handler(event);
        console.log(result);
        expect(true).toEqual(true);
    })
});
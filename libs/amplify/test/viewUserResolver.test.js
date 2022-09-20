const AWS = require("aws-sdk");

require('dotenv').config();
const event = {
    arguments: {
        user_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd"   
    }
};

jest.setTimeout(1000000);

describe("ViewUserResolver Integration Test", () =>{

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

    test("View User", async () =>{

        const handlerModule = require('../amplify/backend/function/viewUserResolver/src/index');
        
        const result = await handlerModule.handler(event);

        //check that some known values of the user are correctly returned
        expect(result.cellNo).toEqual('0832721014');
        expect(result.email).toEqual('lastrucci61@gmail.com');
        expect(result.id).toEqual('c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd');
        expect(result.location.address.province).toEqual('Gauteng');
    })
});
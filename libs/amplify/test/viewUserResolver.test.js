const AWS = require("aws-sdk");

require('dotenv').config();
const event = {
    arguments: {
        user_id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5"   
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
        expect(result.email).toEqual('lastrucci61@gmail.com');
        expect(result.id).toEqual('c#983b506a-8ac3-4ca0-9844-79ed15291cd5');
        expect(result.location.address.province).toEqual('Gauteng');
    })
});
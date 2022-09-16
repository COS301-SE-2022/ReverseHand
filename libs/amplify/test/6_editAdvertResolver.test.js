const AWS = require("aws-sdk");
require('dotenv').config();

const event = {
    arguments: {
        ad_id : "a#d7efa8e0-cb7d-4db2-a295-0d6c6f051b24",
        title : "Lambda Test Two",
        type : "Painting",
        description : "This is a second test description"
    }
};

jest.setTimeout(1000000);

describe("Create Advert Resolver", () =>{
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

    test("Changing advert details of existing advert", async () =>{
        const handlerModule = require('../amplify/backend/function/editAdvertResolver/src/index');
        const result = await handlerModule.handler(event);

        expect(result.title).toEqual('Lambda Test Two');
        expect(result.description).toEqual('This is a second test description');
        expect(result.type).toEqual('Painting');

    });
});



//a#d7efa8e0-cb7d-4db2-a295-0d6c6f051b24
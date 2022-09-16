const AWS = require("aws-sdk");
require('dotenv').config();

const event = {
    arguments: {
        customer_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd",
        title: "Lambda Test One",
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

    test("Testing Advert Details from advert that was created", async () =>{
        const handlerModule = require('../amplify/backend/function/createAdvertResolver/src/index');
        const result = await handlerModule.handler(event);

        expect(result.title).toEqual('Lambda Test One');
        expect(result.description).toEqual('This is a test description');
        expect(result.type).toEqual('Plumbing');

    })
});

/*   
    *Some minor details to be deleted later
    {
      title: 'Lambda Test One',
      description: 'This is a test description',
      domain: {
        city: 'Pretoria',
        province: 'Gauteng',
        coordinates: { lng: 28.2625799, lat: -25.7670289 }
      },
      type: 'Plumbing',
      date_created: 1663324591768,
      id: 'a#6ac1daf9-45a0-49c3-8a80-be34f1b2babe'
    }

*/
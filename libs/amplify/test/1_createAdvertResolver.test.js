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

const eventTwo = {
    arguments: {
        customer_id : "c#f0fa74ae-7a4d-4674-8ba6-e9da6f6213cd",
        title: "Lambda Test Five",
        description: "This is a test description 5",
        domain :{
            city: "Pretoria",
            province: "Gauteng",
            coordinates : {
                lng: 28.2625799,
                lat: -25.7670289
            }
        },
        type: "Painting",
    }
};

jest.setTimeout(1000000);

describe("Create Advert Resolver and Delete Advert Resolver", () =>{

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

    });

    test("Testing Delete advert Resolver", async ()=>{
        //first create the advert
        const handlerModule = require('../amplify/backend/function/createAdvertResolver/src/index');
        const result = await handlerModule.handler(eventTwo);

        expect(result.title).toEqual("Lambda Test Five");//verify the advert was created
        let adId = result.id;

        //now delete the advert
        const eventThree = {
            arguments : {
                ad_id : adId
            }
        };

        const handlerModuleTwo = require('../amplify/backend/function/deleteAdvertResolver/src/index');
        const resultTwo = await handlerModuleTwo.handler(eventThree);

        expect(resultTwo.title).toEqual("Lambda Test Five");//make sure the right advert was deleted
    });
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
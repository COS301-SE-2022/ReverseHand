const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const UserTable = process.env.USER;
const ReverseHandTable = process.env.REVERSEHAND;


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {

        //get the user details
        let params = {
            TableName: UserTable,
            Key:{
                user_id: event.arguments.user_id,
            }
        };

        //data which should be available regardless of whether user is a consumer or tradesman
        let data = await docClient.get(params).promise();

        let ratingSum = data['Item']['sum'];
        let reviews = data['Item']['reviews'];

        //consumer variables
        let numAdvertsCreated = "";//number of adverts that a consumer created
        let numAdvertsWon = 0; //adverts which got completed by a tradesman

        //tradesman variables
        let numBidsCreated = "";
        let numJobsWon = 0;
        
        
        if((event.arguments.user_id).charAt(0) == 'c') //data which is specific to a consumer
        {
            //get the adverts for the Consumer
            params = {
                TableName: ReverseHandTable,
                IndexName: "customer_view",
                KeyConditionExpression: "customer_id = :p",
                ExpressionAttributeValues: {
                    ":p": event.arguments.user_id, // should be a consumers id
                }
            };
    
            data = await docClient.query(params).promise();

            numAdvertsCreated = data['Count'];

            (data['Items']).forEach(advert => {
                if(advert['advert_details']['date_closed'] != null)//find the number of closed advaerts
                    numAdvertsWon += 1;
            });

            numAdvertsWon = numAdvertsWon;//.toString();//convert the int to a string
        }
        else //data which is specific to a tradesman
        {
            //get all bids made by the tradesman
            //get all information related to the tradesman


            params = {
                TableName: ReverseHandTable,
                IndexName: "tradesman_view",
                KeyConditionExpression: "tradesman_id = :p",
                ExpressionAttributeValues: {
                    ":p": event.arguments.user_id, // should be a tradesman id
                }
            };

            data = await docClient.query(params).promise();

            numBidsCreated = data['Count'];
            console.log(numBidsCreated);

            (data['Items']).forEach(bid => {
                console.log(bid);
            });

            //Need to get bids won by the tradesman
        }

        let result = {
            rating_sum : ratingSum,
            num_review : (reviews.length).toString()
        };

        console.log(result);

        
    } catch (error) {
        console.log(error);
    }
};

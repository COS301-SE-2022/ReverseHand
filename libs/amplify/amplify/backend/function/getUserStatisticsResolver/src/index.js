const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();

const UserTable = process.env.USER;
const ReverseHandTable = process.env.REVERSEHAND;
const ArchivedReverseHandTable = process.env.ARCHIVEDREVERSEHAND;

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
        let numAdvertsCreated = 0;//number of adverts that a consumer created
        let numAdvertsWon = 0; //adverts which got completed by a tradesman

        //tradesman variables
        let numBidsCreated = 0;
        let numJobsWon = 0;

        let won = 0;
        let created = 0;
        
        
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

            // getting from archived table
            params = {
                TableName: ArchivedReverseHandTable,
                IndexName: "customer_view",
                KeyConditionExpression: "customer_id = :p",
                ExpressionAttributeValues: {
                    ":p": event.arguments.user_id, // should be a consumers id
                }
            };
    
            data = await docClient.query(params).promise();
            numAdvertsCreated += data['Count'];

            data['Items'].forEach(advert => {
                if(advert['advert_details']['accepted_bid'] != null) //find the number of closed advaerts
                    numAdvertsWon += 1;
            });

            won = numAdvertsCreated;
            created = numAdvertsWon;
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

            let Tdata = await docClient.query(params).promise();

            numBidsCreated = Tdata['Count'];

            //Need to get bids won by the tradesman
            numJobsWon = (data['Item']['adverts_won']).length;

            params = {
                TableName: ArchivedReverseHandTable,
                IndexName: "tradesman_view",
                KeyConditionExpression: "tradesman_id = :p",
                ExpressionAttributeValues: {
                    ":p": event.arguments.user_id, // should be a tradesman id
                }
            };

            Tdata = await docClient.query(params).promise();

            numBidsCreated += Tdata['Count'];

            numJobsWon += (data['Item']['adverts_won']).length;

            won = numJobsWon;
            created = numBidsCreated;
        }

        let result = {
            rating_sum : ratingSum,
            num_reviews : reviews.length,
            num_won: won,
            num_created: created,
        };
        
        return result;
    } catch (error) {
        console.log(error);
    }
};

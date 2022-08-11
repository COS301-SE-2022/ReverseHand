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
        let numAdvertsWon = ""; //adverts which got completed by a tradesman

        //tradesman variables
        
        
        if((event.arguments.user_id).charAt(0) == 'c') //data which is specific to a consumer
        {

        }
        else //data which is specific to a tradesman
        {
            

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

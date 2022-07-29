const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let args = [];
        let expressionAttributeNames = {};
        

        if(event.arguments.domains !== undefined){
            args.push('#domains = :domains');
            expressionAttributeNames['#domains'] = 'domains';
        }

        if(event.arguments.location !== undefined){
            args.push('#location = :location');
            expressionAttributeNames['#location'] = 'location';
        }
        

        if(event.arguments.name !== undefined){
            args.push('#name = :name');
            expressionAttributeNames['#name'] = 'name';
        }
        
        if(event.arguments.cellNo !== undefined){
            args.push('#cellNo = :cellNo');
            expressionAttributeNames['#cellNo'] = 'cellNo';
        }
        
               if(event.arguments.tradetypes !== undefined){
            args.push('#tradetypes = :tradetypes');
            expressionAttributeNames['#tradetypes'] = 'tradetypes';
        }

        let updateExpression = 'set ';

        for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
        let expressionAttributeValues = {};

        expressionAttributeValues[':cellNo'] = event.arguments.cellNo;
        expressionAttributeValues[':domains'] = event.arguments.domains;
        expressionAttributeValues[':location'] = event.arguments.location;
        expressionAttributeValues[':name'] = event.arguments.name;
        expressionAttributeValues[':tradetypes'] = event.arguments.tradetypes;

        let params = {
            TableName: UserTable,
            Key: {
                user_id: event.arguments.user_id,
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        };

        await docClient.update(params).promise();

        // getting item to be returned
        params = {
            TableName: UserTable,
            Key: {
                user_id: event.arguments.user_id,
            }
        };

        const data = await docClient.get(params).promise();
        
        let user = data['Item'];
        //formatting for API User Model
        user.id = user.user_id;
        delete user.user_id;
        
        return user;
        
    } catch (error) {
        console.log(error);
    }
};

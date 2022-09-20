const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   try {
      let keys = [];
      event.arguments.domains.forEach(function(location) {
          event.arguments.types.forEach(function(type) {
            keys.push({part_key: location.city + '#' + location.province, sort_key: type});
          });
      });
    // console.log(keys);
            
      let params = {
        RequestItems: {},
      };
      
      params.RequestItems[ReverseHandTable] = {Keys: keys};
      
      let data = await docClient.batchGet(params).promise();
      if (data.Responses.ReverseHand.length == 0) {
          return {"response" : "No adverts found"};
      } 
      
      let adverts = [];
      
      data.Responses.ReverseHand.forEach(function(response) {
        response.advert_list.forEach(function(advert) {
          adverts.push(advert);
        });
      });
      
      params = {
        RequestItems: {},
      };
      
      params.RequestItems[ReverseHandTable] = {Keys: adverts};
      
      data = await docClient.batchGet(params).promise();
      let response = [];
      data.Responses.ReverseHand.forEach(function(ad) {
        ad.advert_details["id"] = ad.part_key;
        ad.advert_details["customer_id"] = ad.customer_id;
        response.push(
            ad.advert_details
        );
      });
      
      return response;
   } catch(e) {console.log(e);}
};

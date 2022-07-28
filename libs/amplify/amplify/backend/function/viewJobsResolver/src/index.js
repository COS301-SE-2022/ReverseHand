const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
   try {
      let keys = [];
      event.arguments.locations.forEach(function(location) {
          event.arguments.types.forEach(function(type) {
            keys.push({part_key: location, sort_key: type});
          });
      });
      
      console.log(keys);
            
      let params = {
        RequestItems: {},
      };
      
      params.RequestItems[ReverseHandTable] = {Keys: keys};
      
      let data = await docClient.batchGet(params).promise();
      if (data.Responses.ReverseHand.length == 0) {
          return {"response" : "No adverts found"};
      } 
      let adverts = data.Responses.ReverseHand[0].advert_list;
           
      let advert_keys = [];
      adverts.forEach(function(ad_id) {
          advert_keys.push({part_key: ad_id, sort_key: ad_id});
      });
    
      
      params = {
        RequestItems: {},
      };
      
      params.RequestItems[ReverseHandTable] = {Keys: advert_keys};
      
      data = await docClient.batchGet(params).promise();
      let response = [];
      data.Responses.ReverseHand.forEach(function(ad) {
        ad.advert_details["id"] = ad.part_key;
        response.push(
            ad.advert_details
        )
      });
      
      return response;
   } catch(e) {console.log(e);}
};

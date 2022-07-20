import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';

/* PLACE API SERVICE */
/* This is a class to make structured requests to the Google Places api and receive structured output */


class PlaceApiService {
  final client = http.Client();
  final String sessionToken;

  PlaceApiService(this.sessionToken); // The session token is to bundle the requests for cost optimisation 
  
  Future<String> getApiKey() async { // This function is to retreive the API key from AWS SecretsManager
    String graphQLDocument = '''query {
      viewKey
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );
    try {
      final data = jsonDecode(
          (await Amplify.API.mutate(request: request).response).data);
      return data['viewKey'];
    } catch (e) {
      return "Fetching Key Failed";
    }
  }

  /* This function returns a list of suggestions from an input string*/
  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final apiKey = await getApiKey();
    final request = //request involes input string, api key and session token. Response type, language and country are hardcoded as address, english & south africa 
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&components=country:za&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // map suggestions to a list
        return result['predictions'] 
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return []; //if no results, return empty list
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  /* This function returns a Place object with a placeId string obtained from a suggestion*/
  Future<Location> getPlaceDetailFromId(String placeId) async {
    final apiKey = await getApiKey();
    final request = //request involes placeId, apiKey and sessiontoken, hardcoded response type to address componenets
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        final coords = result['result']['geometry']['location'];
        // build result from api response
        String streetNumber = "", street = "", city = "", province = "", zipCode = "";
        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            street = c['long_name'];
          }
          if (type.contains('locality')) {
            city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            zipCode = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            province = c['long_name'];
          }
        }
        final coordinates = Coordinates(lat: coords['lat'],long: coords['lng']);
        final address = Address(streetNumber: streetNumber, street: street, city: city, province: province, zipCode: zipCode);
        return Location(address: address, coordinates: coordinates);
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
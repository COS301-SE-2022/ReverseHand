import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';


class PlaceApiService {
  final client = http.Client();
  final sessionToken;

  PlaceApiService(this.sessionToken);
  
  Future<String> getApiKey() async {
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

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final apiKey = await getApiKey();
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&components=country:za&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final apiKey = await getApiKey();
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        final coords = result['result']['geometry']['location'];
        // build result
        final location = Coordinates(lat: coords['lat'],long: coords['long']);
        final place = Place();
        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        }
        place.location = location;
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
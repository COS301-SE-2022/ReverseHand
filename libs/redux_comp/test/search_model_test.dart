import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/geolocation/search_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

void main() {
  Suggestion suggestionOne = Suggestion("placeId1", "description1");
  Suggestion suggestionTwo = Suggestion("placeId2", "description2");

  List<Suggestion> suggestions = [];
  suggestions.add(suggestionTwo);
  suggestions.add(suggestionOne);

  Address address = const Address(
      streetNumber: "streetNumber",
      street: "street",
      city: "city",
      province: "province",
      zipCode: "zipCode");

  Address addressCopy = const Address(
      streetNumber: "streetNumber1",
      street: "street1",
      city: "city1",
      province: "province1",
      zipCode: "zipCode1");

  Location location = Location(
      address: address, coordinates: const Coordinates(lat: 22, lng: 55));

  Location locationCopy = Location(
      address: addressCopy, coordinates: const Coordinates(lat: 88, lng: 99));

  GeoSearch search = GeoSearch(suggestions: suggestions, result: location);

  GeoSearch searchCopyOne = search.copy();
  GeoSearch searchCopyTwo = search.copy(result: locationCopy);

  test("Testing the copy method of GeoSearch", () {
    expect(searchCopyOne.suggestions, search.suggestions);
    expect(searchCopyOne.result, search.result);

    expect(searchCopyTwo.result, locationCopy);
    expect(searchCopyTwo.suggestions, search.suggestions);
  });
}

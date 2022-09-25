import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';

void main() {
  Address address = const Address(
      streetNumber: "streetNumber",
      street: "street",
      city: "city",
      province: "province",
      zipCode: "zipCode");

  Address replaceMentAddress = const Address(
      streetNumber: "356",
      street: "Street One",
      city: "Pretoria",
      province: "Gauteng",
      zipCode: "999");

  Location location = Location(
      address: address, coordinates: const Coordinates(lat: 55, lng: 57));

  Location replacedLocation = location.replace(address: replaceMentAddress);

  test("Testing the Replace method of Locatoin model", () {
    expect(replacedLocation.address, replaceMentAddress);
    expect(replacedLocation.coordinates.lat, 55);
    expect(replacedLocation.coordinates.lng, 57);
  });
}

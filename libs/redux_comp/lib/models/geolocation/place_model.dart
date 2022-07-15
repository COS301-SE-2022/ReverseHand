import 'package:redux_comp/models/geolocation/coordinates_model.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? province;
  String? zipCode;
  Coordinates? location;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.province,
    this.zipCode,
    this.location
  });
}
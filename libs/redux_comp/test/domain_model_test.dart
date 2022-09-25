import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

void main() {
  Domain domain = const Domain(
      city: "city",
      province: "province",
      coordinates: Coordinates(lat: 22, lng: 26));

  Domain domainCopyOne = domain.copy();
  Domain domainCopyTwo = domain.copy(city: "Pretoria");

  test("Testing copy method of Domain model", () {
    expect(domainCopyOne.city, domain.city);
    expect(domainCopyOne.province, domainCopyOne.province);
    expect(domainCopyOne.coordinates, domain.coordinates);

    expect(domainCopyTwo.city, "Pretoria");
    expect(domainCopyTwo.coordinates, domain.coordinates);
    expect(domainCopyTwo.province, domain.province);
  });
}

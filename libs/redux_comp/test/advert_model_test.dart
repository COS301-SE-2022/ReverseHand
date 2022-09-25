import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

void main() {
  const domain = Domain(
      city: "city",
      province: "province",
      coordinates: Coordinates(lat: 22.2, lng: 22.2));

  const ad = AdvertModel(
    id: "a#001",
    title: "Test",
    userId: "u12345",
    domain: domain,
    dateCreated: 123546,
    description: "A description",
    type: "Plumbing",
    acceptedBid: "b#001",
    dateClosed: 55844545,
    advertRank: 1,
    imageCount: 0,
  );

  var adCopy = ad.copy();

  test("Testing AdvertModel copy method", () {
    expect(ad.title, adCopy.title);
    expect(ad.id, adCopy.id);
    expect(ad.description, adCopy.description);
    expect(ad.type, adCopy.type);
    expect(ad.acceptedBid, adCopy.acceptedBid);
    expect(ad.domain, adCopy.domain);
    expect(ad.dateCreated, adCopy.dateCreated);
    expect(ad.dateClosed, adCopy.dateClosed);
    expect(ad.advertRank, adCopy.advertRank);
  });

  test("Testing overloaded equality operator", () {
    expect(true, adCopy == ad); //testing
  });
}

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/methods/populate_adverts.dart';

void main() {
  List<AdvertModel> adverts = [];

  const domain = Domain(
      city: "p",
      province: "province",
      coordinates: Coordinates(lat: 22.2, lng: 22.2));

  const adOne = AdvertModel(
    id: "test",
    title: "Test",
    domain: domain,
    dateCreated: 1246546,
    type: "Painting",
  );

  const adTwo = AdvertModel(
    id: "id",
    title: "title123",
    type: "Carpenter",
    domain: domain,
    dateCreated: 12345,
  );

  adverts.add(adOne);
  adverts.add(adTwo);

  var store = Store<AppState>(initialState: AppState.initial());

  List<Widget> result = populateAdverts(adverts, store);

  test("populateAdverts unit test", () {
    expect(2, result.length);
  });
}

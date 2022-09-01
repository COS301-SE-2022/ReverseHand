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

  const ad = AdvertModel(
      id: "test", title: "Test", domain: domain, dateCreated: 1246546);

  adverts.add(ad);

  var store = Store<AppState>(initialState: AppState.mock());

  List<Widget> result = populateAdverts(adverts, store);

  test("populateAdverts unit test", () {
    expect(1, result.length);
  });
}

import 'dart:collection';

import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/actions/adverts/filter_adverts_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/filter_adverts_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';

Future<void> main() async {
  var store = Store<AppState>(initialState: AppState.initial());

  //Domain for adverts
  Domain domain = const Domain(
      city: "Pretoria",
      province: "province",
      coordinates: Coordinates(lat: 44, lng: 99));

  //creating adverts to sort
  AdvertModel adOne = AdvertModel(
      id: "id1",
      title: "title1",
      type: "Painting",
      domain: domain,
      dateCreated: 789754);
  AdvertModel adTwo = AdvertModel(
      id: "id2",
      title: "title2",
      type: "Plumbing",
      domain: domain,
      dateCreated: 5454546458);
  List<AdvertModel> adverts = [];

  adverts.add(adOne);
  adverts.add(adTwo);

  AppState temp = store.state.copy(adverts: adverts);
  store = Store<AppState>(initialState: temp);

  //Filtering stage
  HashSet<String>? jobTypes = HashSet<String>();
  jobTypes.add("Painting");

  FilterAdvertsModel filter = FilterAdvertsModel(jobTypes: jobTypes);
  FilterAdvertsAction action = FilterAdvertsAction(filter);

  var storeTester = StoreTester.from(store);

  storeTester.dispatch(action);
  TestInfo<AppState> info = await storeTester.wait(FilterAdvertsAction);

  test("Unit Test: Filter Action", () {
    expect(
        1,
        info.state.viewAdverts
            .length); //since the plumbing should get filtered out
  });
}

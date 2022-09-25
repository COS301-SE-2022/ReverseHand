import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/actions/adverts/set_active_ad_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';

void main() async {
  var store = Store<AppState>(initialState: AppState.initial());

  Domain domain = const Domain(
      city: "city",
      province: "province",
      coordinates: Coordinates(lat: 12.1, lng: 22.4));

  AdvertModel adOne = AdvertModel(
      id: "id1",
      title: "title1",
      userId: "u1234",
      type: "type1",
      domain: domain,
      dateCreated: 54424545,
      imageCount: 5);
  AdvertModel adTwo = AdvertModel(
      id: "id2",
      title: "title",
      userId: "u12345",
      type: "PAinter",
      domain: domain,
      dateCreated: 23432423,
      imageCount: 2);

  List<AdvertModel> adverts = [adOne, adTwo];

  AppState temp = store.state.copy(adverts: adverts);
  store = Store<AppState>(initialState: temp);

  var storeTester = StoreTester.from(store);

  SetActiveAdAction action = SetActiveAdAction("id2");

  storeTester.dispatch(action);
  TestInfo<AppState> info = await storeTester.wait(SetActiveAdAction);

  test("Unit Test: Set_Active_Ad_Action test", () {
    expect("id2", info.state.activeAd!.id);
  });
}

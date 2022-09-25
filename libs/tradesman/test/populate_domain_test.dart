import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/methods/populate_domains.dart';
import 'package:tradesman/widgets/card_widget.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  List<Domain> domains = [];

  const domainOne = Domain(
      city: "Pretoria",
      province: "Gauteng",
      coordinates: Coordinates(lat: 22.2, lng: 22.3));

  const domainTwo = Domain(
      city: "city",
      province: "province",
      coordinates: Coordinates(lat: 77.7, lng: 77.8));

  domains.add(domainOne);
  domains.add(domainTwo);

  List<CardWidget> result = populateDomains(store, domains);

  test("populateDomains unit tests", () {
    expect(2, result.length);

    domains = [];
    expect(0, populateDomains(store, domains).length);
  });
}

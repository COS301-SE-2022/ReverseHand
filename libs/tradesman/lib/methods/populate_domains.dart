import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:tradesman/widgets/card_widget.dart';

List<CardWidget> populateDomains(Store<AppState> store, List<Domain> domains) {
  return domains.map((e) => CardWidget(store: store, title: e.city)).toList();
}

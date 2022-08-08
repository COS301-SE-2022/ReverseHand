// code to filter and sort bids for a specific advert
// user cannot be null

import 'package:redux_comp/models/advert_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/filter_adverts_model.dart';

class FilterAdvertsAction extends ReduxAction<AppState> {
  final FilterAdvertsModel filter;

  FilterAdvertsAction(this.filter);

  @override
  AppState? reduce() {
    List<AdvertModel> adverts = [];

    if (filter.domains != null) {}

    return null;
  }
}

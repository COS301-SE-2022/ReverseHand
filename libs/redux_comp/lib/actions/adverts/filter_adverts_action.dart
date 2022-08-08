// code to filter and sort adverts
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

    // if (filter.domains != null) {
    // for (AdvertModel advert in state.adverts) {
    //   if (filter.domains!.contains(advert)) {
    //     adverts.add(advert);
    //   }
    // }
    // }

    if (filter.jobTypes != null) {
      for (AdvertModel advert in state.adverts) {
        if (filter.jobTypes!.contains(advert.type)) {
          adverts.add(advert);
        }
      }
    }

    // filter by distance
    // if (filter.distance != null) {
    //   adverts.removeWhere(
    //     (advert) => !(advert.priceLower >= filter.priceRange!.low &&
    //         advert.priceUpper <= filter.priceRange!.high),
    //   );
    // }

    return state.copy(
      viewAdverts: adverts,
    );
  }
}

// code to filter and sort bids for a specific advert
// user cannot be null

import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/filter_bids_model.dart';

class FilterBidsAction extends ReduxAction<AppState> {
  final FilterBidsModel filter;

  FilterBidsAction(this.filter);

  @override
  AppState? reduce() {
    List<BidModel> bids = [];

    if (filter.includeShortlisted) {
      bids = state.user!.bids +
          state.user!.shortlistBids; // bids and shortlisted bids cannot be null
    } else {
      bids = state.user!.bids;
    }

    // filter by price
    if (filter.priceRange != null) {
      bids.removeWhere(
        (bid) =>
            bid.priceLower >= filter.priceRange!.low &&
            bid.priceUpper >= filter.priceRange!.high,
      );
    }

    // if (filter.ratingLower != null) {
    //   bids.removeWhere(
    //     (bid) =>
    //         bid.,
    //   );
    // }

    if (filter.sort != null) {
      switch (filter.sort!.kind) {
        case Kind.price:
          switch (filter.sort!.direction) {
            case Direction.ascending:
              bids.sort(((a, b) => a.priceLower.compareTo(b.priceLower)));
              break;
            case Direction.descending:
              bids.sort(((a, b) => a.priceUpper.compareTo(b.priceUpper)));
              break;
          }
          break;
        case Kind.rating:
          // todo
          break;
      }
    }

    return state.replace(
      user: state.user!.replace(
        viewBids: bids,
      ),
    );
  }
}

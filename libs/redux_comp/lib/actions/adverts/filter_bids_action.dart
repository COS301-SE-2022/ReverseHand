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
    List<BidModel> viewBids = [];

    // bids and shortlisted bids cannot be null
    if (filter.includeShortlisted) {
      viewBids += state.shortlistBids;
    }

    if (filter.includeBids) {
      viewBids += state.bids;
    }

    // filter by price
    if (filter.price != null) {
      viewBids.removeWhere((bid) => !(bid.price > filter.price!));
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
            case Direction.descending:
              viewBids.sort((a, b) => a.price.compareTo(b.price));
              break;
            case Direction.ascending:
              viewBids.sort((a, b) => b.price.compareTo(a.price));
              break;
          }
          break;
        case Kind.rating:
          // todo
          break;
        case Kind.date:
          if (filter.sort!.direction == Direction.ascending) {
            viewBids.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
          } else {
            viewBids.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
          }
          break;
      }
    }

    return state.copy(
      viewBids: viewBids,
    );
  }
}

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/bid_model.dart';
import '../../app_state.dart';

class ShortlistBidAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      shortListBid(ad_id: "${state.activeAd!.id}", bid_id: "${state.activeBid!.id}") {
        id
        name
        tradesman_id
        price
        quote
        date_created
        date_closed
        shortlisted
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      /* final response = await */ Amplify.API
          .mutate(request: request)
          .response;
      // debugPrint(response.data);

      // final BidModel shortListedBid =
      //     BidModel.fromJson(jsonDecode(response.data)['shortListBid']);

      List<BidModel> bids = store.state.bids;
      List<BidModel> shortListBids = state.shortlistBids;

      final BidModel shortListedBid =
          state.activeBid!.copy(shortlisted: !state.activeBid!.shortlisted);

      if (shortListedBid.shortlisted) {
        shortListBids.add(shortListedBid);
        bids.removeWhere((element) => element.id == shortListedBid.id);
      } else {
        bids.add(shortListedBid);
        shortListBids.removeWhere((element) => element.id == shortListedBid.id);
      }

      return state.copy(
        change: !state.change,
        bids: bids,
        shortlistBids: shortListBids,
        activeBid: shortListedBid,
        viewBids: bids + shortListBids,
      );
    } catch (e) {
      return null;
    }
  }
}

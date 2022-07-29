import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/bid_model.dart';
import '../../app_state.dart';

class ShortlistBidAction extends ReduxAction<AppState> {
  ShortlistBidAction();

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      shortListBid(ad_id: "${state.activeAd!.id}", bid_id: "${state.activeBid!.id}") {
        id
        name
        tradesman_id
        price_lower
        price_upper
        quote
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      final response = await Amplify.API.mutate(request: request).response;

      List<BidModel> shortListBids = state.shortlistBids;
      final BidModel shortListedBid =
          BidModel.fromJson(jsonDecode(response.data)['shortListBid']);
      shortListBids.add(shortListedBid);

      List<BidModel> bids = store.state.bids;
      bids.removeWhere((element) => element.id == store.state.activeBid!.id);

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

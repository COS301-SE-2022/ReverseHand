import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../models/bid_model.dart';

class ShortlistBidAction extends ReduxAction<AppState> {
  final String adId;
  final String bidId;

  ShortlistBidAction(this.adId, this.bidId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      shortListBid(ad_id: "$adId", bid_id: "$bidId") {
        id
        user_id
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

      List<BidModel> shortListBids = state.user!.shortlistBids;
      final BidModel shortListedBid =
          BidModel.fromJson(jsonDecode(response.data)['shortListBid']);
      shortListBids.add(shortListedBid);

      List<BidModel> bids = [];

      for (BidModel bid in store.state.user!.bids) {
        if (bid.id != bidId) {
          bids.add(bid);
        }
      }

      return state.replace(
        user: state.user!.replace(
          bids: bids,
          shortlistBids: shortListBids,
          activeBid: shortListedBid,
        ),
      );
    } catch (e) {
      return state;
    }
  }
}

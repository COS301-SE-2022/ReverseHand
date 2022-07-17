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
      shortListBid(ad_id: "${state.user!.activeAd!.id}", bid_id: "${state.user!.activeBid!.id}") {
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

      List<BidModel> shortListBids = state.user!.shortlistBids;
      final BidModel shortListedBid =
          BidModel.fromJson(jsonDecode(response.data)['shortListBid']);
      shortListBids.add(shortListedBid);

      List<BidModel> bids = store.state.user!.bids;
      bids.removeWhere(
          (element) => element.id == store.state.user!.activeBid!.id);

      return state.replace(
        change: !state.change,
        user: state.user!.replace(
          bids: bids,
          shortlistBids: shortListBids,
          activeBid: shortListedBid,
          viewBids: bids + shortListBids,
        ),
      );
    } catch (e) {
      return null;
    }
  }
}

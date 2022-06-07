import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../app_state.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
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
        advert_id
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
      shortListBids.add(BidModel.fromJson(response.data['shortListBid']));

      return state.replace(
          user: state.user!.replace(shortlistBids: shortListBids));
    } catch (e) {
      return state;
    }
  }
}

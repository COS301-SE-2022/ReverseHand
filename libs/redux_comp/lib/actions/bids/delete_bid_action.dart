import 'package:flutter/cupertino.dart';
import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class DeleteBidAction extends ReduxAction<AppState> {
  final String? advertId;
  final String? bidId;

  DeleteBidAction({this.advertId, this.bidId});

  @override
  Future<AppState?> reduce() async {
    String advertId = this.advertId ?? state.activeAd!.id;
    String bidId = this.bidId ?? state.userBid!.id;

    String graphQLDocument = ''' mutation {
      deleteBid(ad_id: "$advertId", bid_id:"$bidId") {
        id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;

      debugPrint(response.data);

      List<BidModel> bids = state.bids;
      List<BidModel> shortlistBids = state.shortlistBids;

      bids.remove(state.userBid);
      shortlistBids.remove(state.userBid);

      return state.copy(
        makeUserBidNull: true,
        bids: bids,
        shortlistBids: shortlistBids,
      );
    } catch (e) {
      return null;
    }
  }
}

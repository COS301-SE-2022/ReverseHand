import 'dart:convert';
import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EditBidAction extends ReduxAction<AppState> {
  final String? advertId;
  final String? bidId;
  final String? quote;
  final int? price;

  EditBidAction({
    this.advertId,
    this.bidId,
    this.quote,
    this.price,
  });

  // NB: At time of creating this code, a bid still didn't have a quote but
  // it is suppossed to have one. That can be a potential error as the code
  // expects a quote

  @override
  Future<AppState?> reduce() async {
    String advertId = this.advertId ?? state.activeAd!.id;
    String bidId = this.bidId ?? state.userBid!.id;

    String priceParam = "";
    if (price != null) priceParam = ''', price: ${price!}''';

    String graphQLDocument = '''mutation {
      editBid(ad_id: "$advertId", bid_id: "$bidId"$priceParam){
        id
        name
        tradesman_id
        price
        date_created
        date_closed
        shortlisted
        quote
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      final response = await Amplify.API.mutate(request: request).response;
      final data = jsonDecode(response.data)['editBid'];

      BidModel bid = BidModel.fromJson(data);

      List<BidModel> bids = state.bids;

      //remove the bid that was changed from the list
      int pos = -1;
      for (int i = 0; i < bids.length; i++) {
        if (bids[i].id == bid.id) {
          pos = i;
          break;
        }
      }
      bids[pos] = bid;

      return state.copy(
        bids: bids,
        userBid: bid,
        change: !state.change,
      );
    } catch (e) {
      return null;
    }
  }
}

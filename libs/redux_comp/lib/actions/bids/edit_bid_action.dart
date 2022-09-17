import 'dart:convert';
import 'dart:ffi';
import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EditBidAction extends ReduxAction<AppState> {
  final String advertId;
  final String bidId;
  final String quote;
  final Int price;

  EditBidAction(this.advertId, this.bidId, this.quote, this.price);

  // NB: At time of creating this code, a bid still didn't have a quote but
  // it is suppossed to have one. That can be a potential error as the code
  // expects a quote

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      editBid(ad_id: "$advertId", bid_id: "$bidId", quote: "$quote", price: "$price"){
        quote
        price_lower
        price_upper
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      final data = jsonDecode(
          (await Amplify.API.mutate(request: request).response).data);

      List<BidModel> bids = state.bids;

      //get the bid being edited
      BidModel bd = bids.firstWhere((element) => element.id == bidId);
      //remove the bid that was changed from the list
      bids.removeWhere((element) => element.id == bidId);
      bids.add(BidModel.fromJson(data));

      return state.copy(bids: bids);
    } catch (e) {
      return null;
    }
  }
}

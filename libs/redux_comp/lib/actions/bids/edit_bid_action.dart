import 'dart:convert';
import 'dart:ffi';

import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/bid_model.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EditBidAction extends ReduxAction<AppState> {
  final String advertId;
  final String bidId;
  final String quote;
  final Int priceUpper;
  final Int priceLower;

  EditBidAction(
      this.advertId, this.bidId, this.quote, this.priceUpper, this.priceLower);

  // NB: At time of creating this code, a bid still didn't have a quote but
  // it is suppossed to have one. That can be a potential error as the code
  // expects a quote

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = ''' mutation {
      editBid(ad_id: "$advertId", bid_id: "$bidId" ){
        quote: "$quote",
        price_lower: "$priceLower",
        price_upper: "$priceUpper"
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      final data = jsonDecode(
          (await Amplify.API.mutate(request: request).response).data);

      List<BidModel> bids = state.user!.bids;

      //get the bid being edited
      BidModel bd = bids.firstWhere((element) => element.id == bidId);
      //remove the bid that was changed from the list
      bids.removeWhere((element) => element.id == bidId);
      //update the bid as a new bid
      bids.add(BidModel(
          id: bd.id,
          userId: bd.userId,
          priceLower: data["price_lower"],
          priceUpper: data["price_upper"],
          dateCreated: bd.dateCreated,
          quote: data["quote"],
          name: bd.name));

      return state.copy(user: state.user!.copy(bids: bids));
    } catch (e) {
      return null;
    }
  }
}

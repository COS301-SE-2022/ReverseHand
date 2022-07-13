import 'dart:ffi';

import 'package:amplify_api/amplify_api.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EditBidAction extends ReduxAction<AppState> {
  final String advertId;
  final String bidId;
  final String name;
  final Int priceUpper;
  final Int priceLower;

  EditBidAction(
      this.advertId, this.bidId, this.name, this.priceUpper, this.priceLower);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = ''' mutation {
      editBid(ad_id: "$advertId", bid_id: "$bidId" ){
        name: "$name",
        price_lower: "$priceLower",
        price_upper: "$priceUpper"
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      await Amplify.API.mutate(request: request).response;
      return null;
    } catch (e) {
      return null;
    }
  }
}

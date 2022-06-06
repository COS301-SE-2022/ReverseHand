import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/bid_model.dart';
// import 'package:flutter/foundation.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ViewBidsAction extends ReduxAction<AppState> {
  final String adId;

  ViewBidsAction(this.adId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewBids(ad_id: "$adId") {
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
      final response = await Amplify.API.query(request: request).response;
      print(response.data);
      print(jsonDecode(response.data));

      List<BidModel> bids = [];

      response.data['viewBids']
          .forEach((el) => bids.add(BidModel.fromJson(el)));

      return state.replace(user: state.user!.replace(bids: bids));
    } catch (e) {
      return state;
    }
  }
}

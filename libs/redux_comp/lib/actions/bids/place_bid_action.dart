import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class PlaceBidAction extends ReduxAction<AppState> {
  final String? adId;
  final String? userId;
  final int price;
  final String? quote;

  PlaceBidAction({
    required this.price,
    this.userId,
    this.adId,
    this.quote,
  });

  @override
  Future<AppState?> reduce() async {
    final String adId = this.adId ?? state.activeAd!.id;
    final String userId = this.userId ?? state.userDetails.id;

    // type is not used currently but will be implemented in the future
    String graphQLDocument = '''mutation {
      placeBid(ad_id: "$adId", tradesman_id: "$userId", name: "${state.userDetails.name}", price: $price, quote: "$quote") {
        id
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      final resp = await Amplify.API
          .mutate(request: request)
          .response; // currently don't need a response return but maybe later
      debugPrint(resp.data);
      return null; // no change to state currently
    } catch (e) {
      return null;
    }
  }

  @override
  void after() => dispatch(ViewBidsAction());
}

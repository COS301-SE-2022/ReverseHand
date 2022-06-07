import 'package:amplify_api/amplify_api.dart';
import 'package:uuid/uuid.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class PlaceBidAction extends ReduxAction<AppState> {
  final String adId;
  final String userId;
  final int priceLower;
  final int priceUpper;
  final String? quote;

  PlaceBidAction(
    this.adId,
    this.userId,
    this.priceLower,
    this.priceUpper, {
    this.quote,
  });

  @override
  Future<AppState?> reduce() async {
    String bidId = const Uuid().v1();

    // type is not used currently but will be implemented in the future
    String graphQLDocument = '''mutation {
      placeBid(ad_id: "$adId", bid_id: "$bidId", user_id: "$userId", price_lower: "$priceLower", price_upper: "$priceUpper", quote: "$quote") {
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
      await Amplify.API
          .mutate(request: request)
          .response; // currently don't need to response return but may be later

      return state; // no change to bid currently
    } catch (e) {
      return state;
    }
  }
}

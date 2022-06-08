import 'package:amplify_api/amplify_api.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AcceptBidAction extends ReduxAction<AppState> {
  final String adId;
  final String sbidId;
  final String userId;

  AcceptBidAction(this.userId, this.adId, this.sbidId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      acceptBid(user_id: "$userId", ad_id: "$adId", sbid_id: "$sbidId") {
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
      // getting the bid which has beena accepted is just a graphql convention
      await Amplify.API
          .mutate(request: request)
          .response; // in futre may want to do something with accepted advert

      return null; // currently no change in state required
    } catch (e) {
      return null;
    }
  }
}

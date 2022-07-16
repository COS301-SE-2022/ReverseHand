import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/bid_model.dart';
import '../../app_state.dart';

class AcceptBidAction extends ReduxAction<AppState> {
  AcceptBidAction();

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      acceptBid(user_id: "${state.user!.id}", ad_id: "${state.user!.activeAd!.id}", sbid_id: "${state.user!.activeBid!.id}") {
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
      // getting the bid which has beena accepted is just a graphql convention
      await Amplify.API
          .mutate(request: request)
          .response; // in futre may want to do something with accepted advert

      final List<BidModel> shortBids = state.user!.shortlistBids;
      shortBids
          .removeWhere((element) => element.id == state.user!.activeBid!.id);

      final List<BidModel> viewBids = state.user!.viewBids;
      viewBids
          .removeWhere((element) => element.id == state.user!.activeBid!.id);

      return state.replace(
        user: state.user!.replace(
          shortlistBids: shortBids,
          viewBids: viewBids,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  void after() => dispatch(NavigateAction
      .pop()); // after bid has been accepted no more to do so leave page
}

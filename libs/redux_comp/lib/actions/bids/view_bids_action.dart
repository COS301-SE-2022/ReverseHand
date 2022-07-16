import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/advert_model.dart';
import '../../app_state.dart';

// pass in the advert id whos bids you want to see
class ViewBidsAction extends ReduxAction<AppState> {
  final String adId;

  ViewBidsAction(this.adId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewBids(ad_id: "$adId") {
        id
        name
        tradesman_id
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

      final data = jsonDecode(response.data);

      List<BidModel> bids = [];
      List<BidModel> shortlistedBids = [];

      for (dynamic d in data['viewBids']) {
        String id = d['id'];
        if (id.contains('s')) {
          shortlistedBids.add(BidModel.fromJson(d));
        } else {
          bids.add(BidModel.fromJson(d));
        }
      }

      final AdvertModel ad =
          state.user!.adverts.firstWhere((element) => element.id == adId);

      return state.copy(
        user: state.user!.copy(
          bids: bids,
          shortlistBids: shortlistedBids,
          viewBids: bids + shortlistedBids,
          activeAd: ad, // setting the active ad
        ),
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void after() => dispatch(NavigateAction.pushNamed(
      "/${state.user!.userType.toLowerCase()}/advert_details")); // move to page after action completes
}

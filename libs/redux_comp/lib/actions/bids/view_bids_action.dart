import 'dart:convert';
import 'package:redux_comp/actions/adverts/get_advert_images_action.dart';
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
        shortlisted
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

      // since all bids are gotten we seperate them into two lists
      for (dynamic d in data['viewBids']) {
        final bool shortlisted = d['shortlisted'];
        if (shortlisted) {
          shortlistedBids.add(BidModel.fromJson(d));
        } else {
          bids.add(BidModel.fromJson(d));
        }
      }

      final AdvertModel ad =
          state.adverts.firstWhere((element) => element.id == adId);

      return state.copy(
        bids: bids,
        shortlistBids: shortlistedBids,
        viewBids: bids + shortlistedBids,
        activeAd: ad, // setting the active ad
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("viewBids"));
    dispatch(NavigateAction.pushNamed(
        "/${state.userDetails!.userType.toLowerCase()}/advert_details"));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("viewBids"));
    dispatch(GetAdvertImagesAction());
  } // move to page after action completes
}

import 'dart:convert';
import 'package:redux_comp/actions/adverts/get_advert_images_action.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/advert_model.dart';
import '../../app_state.dart';

// pass in the advert id whos bids you want to see
class ViewBidsAction extends ReduxAction<AppState> {
  final AdvertModel? ad;
  final bool archived;

  ViewBidsAction({this.ad, this.archived = false});

  @override
  Future<AppState?> reduce() async {
    final AdvertModel ad = this.ad ?? state.activeAd!;

    String graphQLDocument = '''query {
      viewBids(ad_id: "${ad.id}", archived: $archived) {
        id
        name
        tradesman_id
        price
        date_created
        date_closed
        shortlisted
        quote
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

      BidModel? userBid;
      BidModel? activeBid;

      // since all bids are gotten we seperate them into two lists
      for (dynamic d in data['viewBids']) {
        final BidModel bid = BidModel.fromJson(d);

        if (bid.shortlisted) {
          shortlistedBids.add(bid);
        } else {
          bids.add(bid);
        }

        // for when a user needs to view their own bid
        if (bid.userId == state.userDetails.id) userBid = bid;

        // for when we close an advert
        if (ad.acceptedBid != null && bid.id == ad.acceptedBid) activeBid = bid;
      }

      if (userBid == null) {
        return state.copy(
          bids: bids,
          makeUserBidNull: true,
          shortlistBids: shortlistedBids,
          viewBids: bids + shortlistedBids,
          activeAd: ad, // setting the active ad
          activeBid: activeBid,
        );
      } else {
        return state.copy(
          bids: bids,
          userBid: userBid,
          shortlistBids: shortlistedBids,
          viewBids: bids + shortlistedBids,
          activeAd: ad, // setting the active ad
          activeBid: activeBid,
        );
      }
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("viewBids"));
    if (archived) {
      dispatch(NavigateAction.pushNamed("/archived_advert_details"));
    } else {
      dispatch(NavigateAction.pushNamed(
          "/${state.userDetails.userType.toLowerCase()}/advert_details"));
    }
  }

  @override
  void after() {
    dispatch(WaitAction.remove("viewBids"));
    dispatch(GetAdvertImagesAction());
  } // move to page after action completes
}

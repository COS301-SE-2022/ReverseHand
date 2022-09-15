import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/actions/adverts/filter_bids_action.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/models/filter_bids_model.dart';
import 'package:redux_comp/redux_comp.dart';

void main() async {
  var store = Store<AppState>(initialState: AppState.initial());

  FilterBidsModel filter = const FilterBidsModel(
      includeShortlisted: true,
      includeBids: true,
      priceRange: Range(500, 1000));

  FilterBidsAction action = FilterBidsAction(filter);

  BidModel bidOne = const BidModel(
      id: "id1",
      userId: "userId1",
      priceLower: 600,
      priceUpper: 800,
      dateCreated: 12345,
      shortlisted: true);

  BidModel bidTwo = const BidModel(
      id: "id2",
      userId: "userId2",
      priceLower: 200,
      priceUpper: 300,
      dateCreated: 454612548,
      shortlisted: true);

  BidModel bidThree = const BidModel(
      id: "id3",
      userId: "userId3",
      priceLower: 700,
      priceUpper: 900,
      dateCreated: 9875215,
      shortlisted: false);

  BidModel bidFour = const BidModel(
      id: "id4",
      userId: "userId4",
      priceLower: 1500,
      priceUpper: 2000,
      dateCreated: 8986561,
      shortlisted: false);

  List<BidModel> shortlistBids = [];
  shortlistBids.add(bidOne);
  shortlistBids.add(bidTwo);

  List<BidModel> bids = [];
  bids.add(bidThree);
  bids.add(bidFour);

  AppState temp = store.state.copy(shortlistBids: shortlistBids, bids: bids);
  store = Store<AppState>(initialState: temp);

  var storeTester = StoreTester.from(store);

  storeTester.dispatch(action);
  TestInfo<AppState> info = await storeTester.wait(FilterBidsAction);

  test("Unit Test: Filter Bids Action Test", () {
    expect(2, info.state.viewBids.length); //should have 2 bids from the 4
  });
}

import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';

void main() async {
  BidModel bidOne = const BidModel(
    id: "id1",
    userId: "userId1",
    priceLower: 200,
    priceUpper: 500,
    dateCreated: 1245645,
    shortlisted: true,
  );

  BidModel bidTwo = const BidModel(
    id: "id4",
    userId: "userId2",
    priceLower: 700,
    priceUpper: 900,
    dateCreated: 454654564,
    shortlisted: true,
  );
  BidModel bidThree = const BidModel(
    id: "id3",
    userId: "userId3",
    priceLower: 500,
    priceUpper: 700,
    dateCreated: 545643215,
    shortlisted: false,
  );
  BidModel bidFour = const BidModel(
    id: "id4",
    userId: "userId4",
    priceLower: 400,
    priceUpper: 600,
    dateCreated: 75645456456,
    shortlisted: false,
  );

  List<BidModel> shortlistBids = [bidOne, bidTwo];
  List<BidModel> viewBids = [bidThree, bidFour];

  var store = Store<AppState>(initialState: AppState.initial());
  AppState temp =
      store.state.copy(shortlistBids: shortlistBids, viewBids: viewBids);
  store = Store<AppState>(initialState: temp);

  ToggleViewBidsAction action = ToggleViewBidsAction(true, true);

  var storeTester = StoreTester.from(store);
  storeTester.dispatch(action);
  TestInfo<AppState> info = await storeTester.wait(ToggleViewBidsAction);

  test("Unit Test: Toggle View Bids Action ", () async {
    expect(4, info.state.viewBids.length); //testing with all true

    //testing with true-false combination
    ToggleViewBidsAction actionTwo = ToggleViewBidsAction(true, false);
    var storeTesterTwo = StoreTester.from(store);
    storeTesterTwo.dispatch(actionTwo);
    TestInfo<AppState> infoTwo =
        await storeTesterTwo.wait(ToggleViewBidsAction);
    expect(1, infoTwo.state.viewBids.length);
  });
}

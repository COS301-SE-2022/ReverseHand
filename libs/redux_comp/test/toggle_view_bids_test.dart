import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';

void main() async {
  BidModel bidOne = const BidModel(
    id: "id1",
    userId: "userId1",
    price: 200,
    dateCreated: 1245645,
    shortlisted: true,
  );

  BidModel bidTwo = const BidModel(
    id: "id4",
    userId: "userId2",
    price: 700,
    dateCreated: 454654564,
    shortlisted: true,
  );
  BidModel bidThree = const BidModel(
    id: "id3",
    userId: "userId3",
    price: 500,
    dateCreated: 545643215,
    shortlisted: false,
  );
  BidModel bidFour = const BidModel(
    id: "id4",
    userId: "userId4",
    price: 400,
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

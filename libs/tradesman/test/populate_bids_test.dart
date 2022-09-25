import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/methods/populate_bids.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  const bidOne = BidModel(
      id: "b#001",
      userId: "u12345",
      price: 10,
      dateCreated: 123456,
      shortlisted: false);
  const bidTwo = BidModel(
      id: "b#002",
      userId: "u12346",
      price: 12,
      dateCreated: 989999989,
      shortlisted: true);

  List<BidModel> bids = [];

  bids.add(bidOne);
  bids.add(bidTwo);

  List<Widget> result = populateBids("u12345", bids, store);

  test("populate bids unit test", () {
    expect(2, result.length);

    bids = [];

    expect(0, (populateBids("u12345", bids, store)).length);
  });
}

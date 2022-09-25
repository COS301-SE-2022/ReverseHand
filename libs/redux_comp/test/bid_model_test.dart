import 'package:redux_comp/models/bid_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const bidOne = BidModel(
      id: "sb#001",
      userId: "userId",
      price: 110,
      dateCreated: 215,
      shortlisted: true);

  const bidTwo = BidModel(
      id: "b#001",
      userId: "userId",
      price: 4,
      dateCreated: 1245,
      shortlisted: false);

  test("Testing isShortListedMethod", () {
    expect("R1", bidOne.amount());
    expect("R0", bidTwo.amount());
  });
}

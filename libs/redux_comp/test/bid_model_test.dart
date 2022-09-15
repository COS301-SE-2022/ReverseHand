import 'package:redux_comp/models/bid_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const bidOne = BidModel(
      id: "sb#001",
      userId: "userId",
      priceLower: 11,
      priceUpper: 22,
      dateCreated: 215);

  const bidTwo = BidModel(
      id: "b#001",
      userId: "userId",
      priceLower: 56,
      priceUpper: 455,
      dateCreated: 1245);

  test("Testing isShortListedMethod", () {
    expect(true, bidOne.isShortlisted());
    expect(false, bidTwo.isShortlisted());
  });

  //need to update this test since there is now a boolean to check if a bid
  //is shortlisted
}

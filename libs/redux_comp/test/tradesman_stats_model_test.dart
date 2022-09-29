import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/user_models/tradesman_stats_model.dart';

void main() {
  TradesmanStatsModel stats =
      const TradesmanStatsModel(numJobsWon: 12, numBidsPlaced: 33);

  TradesmanStatsModel copyOne = stats.copy(numJobsWon: 20);
  TradesmanStatsModel copyTwo = stats.copy(numBidsPlaced: 50);

  test("Unit Test: Copy Method-TradesmanStatsModel", () {
    expect(20, copyOne.numJobsWon);
    expect(33, copyOne.numBidsPlaced);

    expect(12, copyTwo.numJobsWon);
    expect(50, copyTwo.numBidsPlaced);
  });
}

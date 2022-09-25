import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/user_models/consumer_stats_model.dart';

void main() {
  ConsumerStatsModel statsOne =
      const ConsumerStatsModel(numAdvertsWon: 5, numAdvertsCreated: 99);
  ConsumerStatsModel copyOne = statsOne.copy(numAdvertsWon: 55);
  ConsumerStatsModel copyTwo = statsOne.copy(numAdvertsCreated: 100);

  test("Testing Copy Method of ConsumerStatsModel", () {
    expect(55, copyOne.numAdvertsWon);
    expect(99, copyOne.numAdvertsCreated);

    expect(5, copyTwo.numAdvertsWon);
    expect(100, copyTwo.numAdvertsCreated);
  });
}

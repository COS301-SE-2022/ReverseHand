import 'package:flutter/widgets.dart';

// what is passed in to filter and sort bids
@immutable
class FilterBidsModel {
  final Range? priceRange; // range in which to filter price
  final Sort? sort;
  final int? ratingLower; // lower bound for rating
  final int? priceExact; // exact price to search for

  const FilterBidsModel({
    this.priceRange,
    this.ratingLower,
    this.priceExact,
    this.sort,
  });
}

// represents the range for filtering price/rating
@immutable
class Range {
  final int low;
  final int high;

  const Range(this.low, this.high);
}

// class to manage sorting
@immutable
class Sort {
  final Kind kind;
  final Direction direction;

  const Sort(this.kind, this.direction);
}

// the thing we are sorting
enum Kind {
  price,
  rating,
}

// represents the direction in which to sort
enum Direction {
  ascending,
  descending,
}

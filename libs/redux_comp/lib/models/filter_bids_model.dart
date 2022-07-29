import 'package:flutter/widgets.dart';

// what is passed in to filter and sort bids
@immutable
class FilterBidsModel {
  final Range? priceRange; // range in which to filter price
  final Sort? sort; // how to sort
  final int? ratingLower; // lower bound for rating
  final bool includeShortlisted; // whether shortlisted bids should be included
  final bool includeBids; // whether normal bids should be included

  const FilterBidsModel({
    this.priceRange,
    this.ratingLower,
    this.sort,
    required this.includeShortlisted,
    required this.includeBids,
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
  date,
}

// represents the direction in which to sort
enum Direction {
  ascending,
  descending,
}

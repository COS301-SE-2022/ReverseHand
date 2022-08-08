import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

@immutable
class FilterAdvertsModel {
  final Sort? sort;
  final List<Domain>? domains;
  final List<String>? jobTypes;

  const FilterAdvertsModel({
    this.sort,
    this.domains,
    this.jobTypes,
  });
}

// class to manage sorting
@immutable
class Sort {
  final Kind kind;
  final Direction direction;

  const Sort(this.kind, this.direction);
}

// represents the range for filtering distance
@immutable
class Range {
  final int low;
  final int high;

  const Range(this.low, this.high);
}

// the thing we are sorting
enum Kind {
  date,
}

// represents the direction in which to sort
enum Direction {
  ascending,
  descending,
}

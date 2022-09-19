import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

@immutable
class FilterAdvertsModel {
  final Sort? sort;
  final HashSet<String>? domains;
  final HashSet<String>? tradeTypes;
  final double? distance;

  const FilterAdvertsModel({
    this.sort,
    this.domains,
    this.tradeTypes,
    this.distance,
  });
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
  date,
}

// represents the direction in which to sort
enum Direction {
  ascending,
  descending,
}

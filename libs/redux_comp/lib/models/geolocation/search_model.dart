import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

@immutable
class GeoSearch {
  final Address result;
  final List<Suggestion> suggestions;

  const GeoSearch({
    required this.result,
    required this.suggestions,
   
  });

  GeoSearch replace({
    Address? result,
    List<Suggestion>? suggestions,
  }) {
    return GeoSearch(
      result: result ?? this.result,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

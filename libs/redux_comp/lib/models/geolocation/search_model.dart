import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

@immutable
class GeoSearch {
  final Location? result;
  final List<Suggestion> suggestions;

  const GeoSearch({
    this.result,
    required this.suggestions,
   
  });

  GeoSearch copy({
    Location? result,
    List<Suggestion>? suggestions,
  }) {
    return GeoSearch(
      result: result ?? this.result,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

@immutable
class Geolocation {
  final List<Suggestion>? suggestions;
  final Place? result;
  final Coordinates? geocode;

  const Geolocation({
    this.suggestions, this.result, this.geocode
  });

  Geolocation replace({
    List<Suggestion>? suggestions,
    Place? result,
    Coordinates? geocode
  }) {
    return Geolocation(
      suggestions: suggestions ?? this.suggestions,
      result: result ?? this.result,
      geocode: geocode ?? this.geocode
    );
  }
}
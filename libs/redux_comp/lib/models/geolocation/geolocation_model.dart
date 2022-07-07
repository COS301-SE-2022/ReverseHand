import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

@immutable
class Geolocation {
  final List<Suggestion>? suggestions;
  final Place? result;

  const Geolocation({
    this.suggestions, this.result
  });

  Geolocation replace({
    List<Suggestion>? suggestions,
    Place? result
  }) {
    return Geolocation(
      suggestions: suggestions ?? this.suggestions,
      result: result ?? this.result
    );
  }
}
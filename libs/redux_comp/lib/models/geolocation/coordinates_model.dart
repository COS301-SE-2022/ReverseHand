import 'package:flutter/material.dart';

@immutable
class Coordinates {
  final double lat;
  final double lng;

  const Coordinates({
    required this.lat, required this.lng
  });
}
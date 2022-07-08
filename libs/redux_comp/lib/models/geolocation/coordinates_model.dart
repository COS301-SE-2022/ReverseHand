import 'package:flutter/material.dart';

@immutable
class Coordinates {
  final double? lat;
  final double? long;

  const Coordinates({
    this.lat, this.long
  });
}
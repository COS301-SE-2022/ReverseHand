import 'package:flutter/material.dart';

@immutable
class ReviewDetailsModel {
  final String id;
  final int rating;
  final String description;
  final String advertId;

  const ReviewDetailsModel({
    required this.id,
    required this.rating,
    required this.description,
    required this.advertId,
  });

  factory ReviewDetailsModel.fromJson(obj) {
    return ReviewDetailsModel(
      id: obj['id'],
      rating: obj['rating'],
      description: obj['description'],
      advertId: obj['advert_id'],
    );
  }
}

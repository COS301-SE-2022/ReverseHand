import 'package:flutter/material.dart';

@immutable
class Review {
  final String id;
  final int rating;
  final String description;
  final String userId;
  final String advertId;

  const Review(
      {required this.id,
      required this.rating,
      required this.description,
      required this.userId,
      required this.advertId});

  factory Review.fromJson(obj) {
    return Review(
        id: obj['id'],
        rating: obj['rating'],
        description: obj['description'],
        userId: obj['userId'],
        advertId: obj['advertId']);
  }

  @override
  String toString() {
    return """{
        id : "$id",
        rating : "$rating,
        description : "$description",
        user_id : "$userId",
        advert_id : "$advertId"
    }""";
  }
}

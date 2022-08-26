import 'package:flutter/material.dart';

@immutable
class ReviewModel {
  final String id;
  final int rating;
  final String description;
  final String userId;
  final String advertId;
  final int? dateCreated;

  const ReviewModel(
      {required this.id,
      required this.rating,
      required this.description,
      required this.userId,
      required this.advertId,
      this.dateCreated});

  factory ReviewModel.fromJson(obj) {
    return ReviewModel(
        id: obj['id'],
        rating: obj['rating'],
        description: obj['description'],
        userId: obj['userId'],
        advertId: obj['advertId'],
        dateCreated: obj['dateCreated']);
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

import 'package:flutter/material.dart';

@immutable
class ReviewModel {
  final String id;
  final int rating;
  final String description;
  final String userId;
  final String advertId;
  final double dateCreated;

  const ReviewModel({
    required this.id,
    required this.rating,
    required this.description,
    required this.userId,
    required this.advertId,
    required this.dateCreated,
  });

  factory ReviewModel.fromJson(obj) {
    return ReviewModel(
      id: obj['id'],
      rating: obj['rating'],
      description: obj['description'],
      userId: obj['user_id'],
      advertId: obj['advert_id'],
      dateCreated: obj['date_created'].toDouble(),
    );
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

  // implementing hashcode
  @override
  int get hashCode => Object.hash(
        id,
        advertId,
        rating,
        description,
        userId,
        dateCreated,
      );

  @override
  bool operator ==(Object other) {
    return other is ReviewModel &&
        id == other.id &&
        advertId == other.advertId &&
        rating == other.rating &&
        description == other.description &&
        dateCreated == other.dateCreated;
  }
}

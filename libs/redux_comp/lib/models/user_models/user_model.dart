import 'package:flutter/material.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../bid_model.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String userType;
  final List<BidModel> bids;
  final List<BidModel> shortlistBids;
  final List<AdvertModel> adverts;

  const UserModel({
    required this.id,
    required this.email,
    required this.userType,
    required this.bids,
    required this.shortlistBids,
    required this.adverts,
  });

  UserModel replace({
    String? id,
    String? email,
    String? userType,
    List<BidModel>? bids,
    List<BidModel>? shortlistBids,
    List<AdvertModel>? adverts,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      bids: bids ?? this.bids,
      shortlistBids: shortlistBids ?? this.shortlistBids,
      adverts: adverts ?? this.adverts,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../bid_model.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String userType;
  final List<BidModel> bids;
  final List<AdvertModel> adverts;

  const UserModel({
    required this.id,
    required this.email,
    required this.userType,
    required this.bids,
    required this.adverts,
  });

  UserModel replace({
    String? id,
    String? email,
    String? confirmed,
    List<BidModel>? bids,
    List<AdvertModel>? adverts,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userType: confirmed ?? userType,
      bids: bids ?? this.bids,
      adverts: adverts ?? this.adverts,
    );
  }
}

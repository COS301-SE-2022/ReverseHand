import 'package:flutter/material.dart';

import '../bid_model.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String userType;
  final List<BidModel> bids;

  const UserModel({
    required this.id,
    required this.email,
    required this.userType,
    required this.bids,
  });

  UserModel replace({
    String? id,
    String? email,
    String? confirmed,
    List<BidModel>? bids,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userType: confirmed ?? userType,
      bids: bids ?? this.bids,
    );
  }
}

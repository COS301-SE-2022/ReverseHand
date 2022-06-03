// import 'package:amplify/models/Bid.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class ConsumerModel extends UserModel {

  const ConsumerModel(String id, String name, String email)
      : super(id, name, email);

  // List<Bid> getBids() {
  //   return _bids;
  // }

  @override
  UserModel replace({
    String? id,
    String? name,
    String? email,
    // List<Bid>? bids,
  }) {
    return ConsumerModel(
      id ?? getId(),
      name ?? getName(),
      email ?? getEmail(),
      // bids ?? _bids,
    );
  }
}

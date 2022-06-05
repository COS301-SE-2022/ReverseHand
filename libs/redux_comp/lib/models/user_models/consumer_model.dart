// import 'package:amplify/models/Bid.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class ConsumerModel extends UserModel {

  const ConsumerModel(String id, String name, String email, String confirmed)
      : super(id, name, email, confirmed);

  @override
  UserModel replace({
    String? id,
    String? name,
    String? email,
    String? confirmed,
    // List<Bid>? bids,
  }) {
    return ConsumerModel(
      id ?? getId(),
      name ?? getName(),
      email ?? getEmail(),
      confirmed ?? getConfrimed(),
      // bids ?? _bids,
    );
  }
}

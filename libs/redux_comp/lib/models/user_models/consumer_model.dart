import 'package:amplify/models/Bid.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class ConsumerModel extends UserModel {
  final List<Bid> _bids;

  const ConsumerModel(String id, String name, String email, bool confirmed , this._bids)
      : super(id, name, email, confirmed);

  List<Bid> getBids() {
    return _bids;
  }

  @override
  UserModel replace({
    String? id,
    String? name,
    String? email,
    bool? confirmed,
    List<Bid>? bids,
  }) {
    return ConsumerModel(
      id ?? getId(),
      name ?? getName(),
      email ?? getEmail(),
      confirmed ?? getConfrimed(),
      bids ?? _bids,
    );
  }
}

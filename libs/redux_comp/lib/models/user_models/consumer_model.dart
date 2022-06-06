// import 'package:amplify/models/Bid.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

import '../bid_model.dart';

@immutable
class ConsumerModel extends UserModel {
  final List<BidModel> bids;

  const ConsumerModel(String id, String name, String email, this.bids)
      : super(id, name, email);

  // List<Bid> getBids() {
  //   return _bids;
  // }

  @override
  UserModel replace({
    String? id,
    String? name,
    String? email,
    List<BidModel>? bids,
  }) {
    return ConsumerModel(
      id ?? getId(),
      name ?? getName(),
      email ?? getEmail(),
      bids ?? this.bids,
    );
  }
}

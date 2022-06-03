import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class TradesmanModel extends UserModel {
  const TradesmanModel(String id, String name, String email, String confirmed)
      : super(id, name, email, confirmed);

  @override
  UserModel replace() {
    throw UnimplementedError();
  }
}

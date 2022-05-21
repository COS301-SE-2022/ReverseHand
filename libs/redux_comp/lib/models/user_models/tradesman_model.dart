import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class TradesmanModel extends UserModel {
  const TradesmanModel(String name, String email) : super(name, email);
}

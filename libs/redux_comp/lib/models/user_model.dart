import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_models/consumer_model.dart';
import 'package:redux_comp/models/user_models/tradesman_model.dart';

@immutable
abstract class UserModel {
  final String _id;
  final String _name;
  final String _email;

  const UserModel(this._id, this._name, this._email);

  String getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  // convert into required class
  ConsumerModel asConsumer() {
    return this as ConsumerModel;
  }

  TradesmanModel asTradesman() {
    return this as TradesmanModel;
  }
}

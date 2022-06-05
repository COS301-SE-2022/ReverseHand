import 'package:flutter/material.dart';
import 'package:redux_comp/models/error_model.dart';

// used when some item is not found but cannot specify what
// if it is know what cannot be found use the correct error class or create one
@immutable
class NotFoundErrorModel extends ErrorModel {
  const NotFoundErrorModel(String msg) : super(msg: msg);
}

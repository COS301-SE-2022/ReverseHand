import 'package:flutter/material.dart';

// export other errrors
export 'errors/none_error_model.dart';

@immutable
abstract class ErrorModel {
  final String? msg;

  const ErrorModel({this.msg});

  String message() {
    return msg ?? "";
  }
}

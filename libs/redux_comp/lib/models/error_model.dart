import 'package:flutter/material.dart';

// export other errrors
export 'errors/none_error_model.dart';
export 'errors/not_found_error_model.dart';

@immutable
abstract class ErrorModel {
  final String? msg; // msg if one needs to be printed

  const ErrorModel({this.msg});

  // even though msg is public call using method to ensure null safety
  String message() {
    return msg ?? "";
  }
}

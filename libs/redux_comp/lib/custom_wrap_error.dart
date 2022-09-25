import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/error_type_model.dart';

class CustomWrapError extends WrapError<AppState> {
  @override
  UserException? wrap(
      Object error, StackTrace stackTrace, ReduxAction<AppState> action) {
    if (error.runtimeType != UserException) {
      return const UserException("Weird Error");
    }

    final String msg;
    switch ((error as UserException).cause as ErrorType) {
      case ErrorType.none:
        return null;
      case ErrorType.userNotFound:
        msg = "User not found";
        break;
      case ErrorType.userNotVerified:
        msg = "User not verified";
        break;
      case ErrorType.userInvalidPassword:
        msg = "Invalid login credentials";
        break;
      case ErrorType.passwordAttemptsExceeded:
        msg = "Max number of password attempts exceeded";
        break;
      case ErrorType.noInput:
        msg = "Please input a username and password";
        break;
      case ErrorType.paymentCancelled:
        msg = "Payment cancelled";
        break;
      case ErrorType.serverVerificationFailed:
        msg = "Verification with the server failed";
        break;
      case ErrorType.unknownError:
        msg = "An unknown error occured";
        break;
      case ErrorType.reviewBadDescription:
        msg = "A review requires a description";
        break;
      case ErrorType.advertContainsBids:
        msg = "Cannot edit and advert that contains bids";
        break;
      default:
        msg = "Missing error message";
        debugPrint(error.msg);
        break;
    }

    return UserException(msg);
  }
}

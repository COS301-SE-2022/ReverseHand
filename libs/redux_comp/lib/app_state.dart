import 'package:flutter/widgets.dart';
import 'models/error_type_model.dart';
import 'models/user_models/user_model.dart';
import 'models/user_models/partial_user_model.dart';

@immutable
class AppState {
  // put all app state requiered here
  final UserModel? user; // autogenerated user id from amplify
  final PartialUser? partialUser; // autogenerated user id from amplify
  final ErrorType error;
  final bool loading;

  // constructor must only take named parameters
  const AppState({
    required this.user,
    required this.partialUser,
    required this.error,
    required this.loading,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return const AppState(
      user: UserModel(
          id: "", email: "", userType: "userType", bids: [], adverts: []),
      partialUser: null,
      error: ErrorType.none,
      loading: true,
    );
  }

  factory AppState.mock() {
    return const AppState(
      user: UserModel(
        id: "0",
        email: "some@email.com",
        userType: "confirmed",
        bids: [],
        adverts: [],
      ),
      partialUser: PartialUser("some@email.com", "1234", "confirmed"),
      error: ErrorType.none,
      loading: false,
    );
  }

  // easy way to replace store wihtout specifying all paramters
  AppState replace({
    UserModel? user,
    PartialUser? partialUser,
    ErrorType? error,
    bool? loading,
  }) {
    return AppState(
      user: user ?? this.user,
      partialUser: partialUser ?? this.partialUser,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }
}

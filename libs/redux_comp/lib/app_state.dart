import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'models/error_type_model.dart';
import 'models/user_models/user_model.dart';
import 'models/user_models/partial_user_model.dart';

@immutable
class AppState {
  // put all app state requiered here
  final UserModel? user; 
  final PartialUser? partialUser; 
  final List<Suggestion> suggestions; 
  final ErrorType error;
  final bool loading;
  final bool change; // used to show that state changed and must rebuild

  // constructor must only take named parameters
  const AppState({
    required this.user,
    required this.partialUser,
    required this.suggestions,
    required this.error,
    required this.loading,
    required this.change,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return const AppState(
      user: UserModel(
        id: "",
        email: "",
        name: "",
        cellNo: "",
        userType: "",
        bids: [],
        shortlistBids: [],
        viewBids: [],
        adverts: [],
      ),
      partialUser: PartialUser(email: "", group: "", verified: ""),
      suggestions: [],
      error: ErrorType.none,
      loading: true,
      change: false,
    );
  }

  factory AppState.mock() {
    return const AppState(
      user: UserModel(
        id: "0",
        email: "some@email.com",
        name: "Someone",
        cellNo: "0821234567",
        userType: "confirmed",
        bids: [],
        viewBids: [],
        shortlistBids: [],
        adverts: [],
      ),
      partialUser: null,
      suggestions: [],
      error: ErrorType.none,
      loading: false,
      change: false,
    );
  }
  // easy way to replace store wihtout specifying all paramters
  AppState replace({
    UserModel? user,
    PartialUser? partialUser,
    List<Suggestion>? suggestions,
    ErrorType? error,
    bool? loading,
    bool? change,
  }) {
    return AppState(
      user: user ?? this.user,
      partialUser: partialUser ?? this.partialUser,
      suggestions: suggestions ?? this.suggestions,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      change: change ?? this.change,
    );
  }
}

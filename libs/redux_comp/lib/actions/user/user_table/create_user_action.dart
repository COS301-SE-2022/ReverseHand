import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:redux_comp/actions/user/user_table/get_user_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

/* CreateUserAction */
/* This action creates a user of a specified group if they have been verified on signup */

class CreateUserAction extends ReduxAction<AppState> {
  final String name;
  final String cellNo;
  final Location? location;
  final List<Domain>? domains;
  final List<String>? tradeTypes;

  CreateUserAction(
      {required this.name,
      required this.cellNo,
      this.location,
      this.domains,
      this.tradeTypes});

  @override
  Future<AppState?> reduce() async {
    //pass user information into variables
    final id = state.userDetails.id;
    final email = state.userDetails.email;
    // different queries for different users
    // If tradesman, DO store domains and tradetypes
    if (state.userDetails.userType == "Tradesman") {
      if (domains == null || domains!.isEmpty) {
        return state.copy(
            error:
                ErrorType.domainsNotCaptured); //Don't create tradesman user if
      }
      if (tradeTypes == null || tradeTypes!.isEmpty) {
        return state.copy(error: ErrorType.tradeTypesNotCaptured);
      }

      List<String> domainsQuery = [];

      for (Domain domain in domains!) {
        domainsQuery.add(domain.toString());
      }

      String graphQLDoc = '''mutation  {
          createUser(
            user_id: "$id", 
            email: "$email", 
            name: "$name", 
            cellNo: "$cellNo", 
            domains: $domainsQuery,
            tradetypes: ${jsonEncode(tradeTypes)},
          ) {
            id
          }
        }
        ''';

      final requestCreateUser = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final resp =
            await Amplify.API.mutate(request: requestCreateUser).response;
        debugPrint(resp.data);
        return state.copy(
            userDetails: state.userDetails.copy(
                name: name,
                cellNo: cellNo,
                tradeTypes: tradeTypes,
                domains: domains,
                location: null,
                registered: true));
      } on ApiException catch (e) {
        debugPrint(e.message);
        return state.copy(error: ErrorType.failedToCreateUser);
      }
    } else if (state.userDetails.userType == "Consumer") {
      if (location == null) {
        return state.copy(error: ErrorType.locationNotCaptured);
      }

      String locationQuery = location.toString();

      String graphQLDoc = '''mutation  {
          createUser(
            user_id: "$id", 
            email: "$email", 
            name: "$name", 
            cellNo: "$cellNo", 
            location: $locationQuery
          ) {
            id
          }
        }
        ''';

      final requestCreateUser = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final resp =
            await Amplify.API.mutate(request: requestCreateUser).response;
        debugPrint(resp.data);
        return state.copy(
            userDetails: state.userDetails.copy(
                name: name,
                cellNo: cellNo,
                location: location,
                registered: true));
      } on ApiException catch (e) {
        debugPrint(e.message);
        return state.copy(error: ErrorType.failedToCreateUser);
      }
    } else {
      return state.copy(error: ErrorType.failedToCreateUser);
    }
  }

  @override
  Future<void> after() async {
    dispatch(GetUserAction());
  }

  // sends error messages to CustomWrapError
  @override
  Object wrapError(error) {
    return error;
  }
}

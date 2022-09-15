import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class EditUserDetailsAction extends ReduxAction<AppState> {
  final String userId;
  final String changed;
  final String? name;
  final String? cellNo;
  final List<Domain>? domains; //for domains
  final List<String>? tradeTypes;
  final Location? location;

  EditUserDetailsAction({
    required this.userId,
    required this.changed,
    this.name,
    this.cellNo,
    this.domains,
    this.tradeTypes,
    this.location,
  });

  @override
  Future<AppState?> reduce() async {
    try {
      switch (changed) {
        case "name":
          String graphQLDoc = '''mutation  {
            editUserDetail(user_id: "$userId", name: "$name") {
              id
            }
          }''';

          final requestChangeName = GraphQLRequest(
            document: graphQLDoc,
          );

          await Amplify.API.mutate(request: requestChangeName).response;

          return state.copy(userDetails: state.userDetails.copy(name: name));
        case "cellNo":
          String graphQLDoc = '''mutation  {
            editUserDetail(user_id: "$userId", cellNo: "$cellNo") {
              id
              cellNo
            }
          }''';

          final requestChangeName = GraphQLRequest(
            document: graphQLDoc,
          );

          await Amplify.API.mutate(request: requestChangeName).response;
          return state.copy(
              userDetails: state.userDetails.copy(cellNo: cellNo));
        case "location":
          String locationInput = location.toString();
          String graphQLDoc = '''mutation  {
            editUserDetail(user_id: "$userId", location: $locationInput) {
              id
            }
          }''';

          final requestChangeName = GraphQLRequest(
            document: graphQLDoc,
          );

          await Amplify.API.mutate(request: requestChangeName).response;
          return state.copy(
              userDetails: state.userDetails.copy(location: location));
        case "domains":
          List<String> domainsQuery = [];
          for (Domain domain in domains!) {
            domainsQuery.add(domain.toString());
          }
          String graphQLDoc = '''mutation  {
            editUserDetail(user_id: "$userId", domains: $domainsQuery) {
              id
              domains {
                city
                province
              }
            }
          }''';

          final requestChangeName = GraphQLRequest(
            document: graphQLDoc,
          );

          await Amplify.API.mutate(request: requestChangeName).response;
          return state.copy(
              userDetails: state.userDetails.copy(domains: domains));
        case "tradetypes":
          String graphQLDoc = '''mutation  {
            editUserDetail(user_id: "$userId", tradetypes: ${jsonEncode(tradeTypes)}) {
              id
              tradetypes
            }
          }''';

          final requestChangeName = GraphQLRequest(
            document: graphQLDoc,
          );

          await Amplify.API.mutate(request: requestChangeName).response;
          return state.copy(
              userDetails: state.userDetails.copy(tradeTypes: tradeTypes));
        default:
          return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("EditProfile"));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("EditProfile"));
  }
}

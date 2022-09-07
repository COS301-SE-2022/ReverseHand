import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/cognito_user_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

class ListUsersInGroupAction extends ReduxAction<AppState> {
  final String groupName;
  final String? nextToken;
  final client = http.Client();

  ListUsersInGroupAction({required this.groupName, this.nextToken});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = ''' query
    {
      listUsersInGroup(group: "$groupName", nextToken: $nextToken) {
        users {
          email
          enabled
          id
        }
        nextToken
      }
    }

    ''';

    final request = GraphQLRequest(document: graphQLDoc);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<CognitoUserModel> users = [];

      dynamic data = jsonDecode(response.data)['listUsersInGroup'];

      for (dynamic user in data["users"]) {
        users.add(CognitoUserModel.fromJson(user));
      }
      return state.copy(
        admin: state.admin.copy(activeCognitoUsers: users, pagenationToken: data["nextToken"]),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(
        admin: state.admin.copy(activeCognitoUsers: []),
      );
    } catch (e) {
      debugPrint(e.toString());
      return state.copy(
        admin: state.admin.copy(activeCognitoUsers: []),
      );
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("ListUsers"));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("ListUsers"));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetReportedReviewsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query {
      getReportedReviews {
        id
        email
        name
        cellNo
        user_reports {
          description
          reason
          reporter_id
        }
      }
    }''';

    final request = GraphQLRequest(document: graphQLDoc);

    try {
      final response = await Amplify.API.query(request: request).response;

      for (GraphQLResponseError err in response.errors) {
        if (err.message == "No user's found") {
          return state.copy(admin: state.admin.copy(activeAdverts: []));
        }
      }

      List<ReportedUserModel> users = [];

      dynamic data = jsonDecode(response.data)['getReportedUsers'];

      for (dynamic user in data) {
        users.add(ReportedUserModel.fromJson(user));
      }
      return state.copy(
        admin: state.admin.copy(activeUsers: users),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(
        admin: state.admin.copy(activeUsers: []),
      );
    } catch (e) {
      debugPrint(e.toString());
      return state.copy(
        admin: state.admin.copy(activeUsers: []),
      );
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("ReportedUsers"));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("ReportedUsers"));
  }
}

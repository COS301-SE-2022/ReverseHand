import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetUserReportsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query  {
      getReports(type: "user#reports") {
        reports {
          report_details {
            description
            reason
            reported_user {
              name
              id
            }
            reporter_user {
              id
              name
            }
          }
          id
          report_type
        }
      }
    }
    ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["getReports"];

      List<ReportModel> reports = [];
      for (dynamic d in data["reports"]) {
        reports.add(ReportModel.fromJson(d));
      }

      return state.copy(
        admin: state.admin.copy(
          adminManage: state.admin.adminManage.copy(userReports: reports),
        ),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("user_reports"));
  }

  @override
  void after() => dispatch(WaitAction.remove("user_reports"));
}

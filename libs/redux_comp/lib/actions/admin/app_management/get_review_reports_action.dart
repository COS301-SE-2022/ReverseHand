import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';

import '../../../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetReviewReportsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query MyQuery {
      getReports(type: "review#reports") {
        reports {
          id
          user_id
          report_type
          report_details {
            description
            reason
            reporter_user {
              id
              name
            }
          }
          review_details {
            advert_id
            description
            id
            rating
          }
        }
        next_token
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
          adminManage: state.admin.adminManage.copy(reviewReports: reports),
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
    dispatch(WaitAction.add("review_reports"));
  }

  @override
  void after() => dispatch(WaitAction.remove("review_reports"));
}

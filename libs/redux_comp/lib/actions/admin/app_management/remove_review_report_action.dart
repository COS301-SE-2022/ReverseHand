import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class RemoveReviewReportAction extends ReduxAction<AppState> {
  final String reportId;
  final String userId;
  final bool issueWarning;

  RemoveReviewReportAction({required this.reportId, required this.userId, required this.issueWarning});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation  {
      removeReviewReport(issueWarning: $issueWarning, report_id: "$reportId", user_id: "$userId") {
        description
        reason
        reported_user {
          id
        }
        reporter_user {
          id
        }
      }
    }''';
    final request = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
       final response =  await Amplify.API
          .mutate(request: request)
          .response;

      debugPrint(response.data);
      return null;
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null; // on error does not modify appstate
    } catch (e) {
      debugPrint(e.toString());
      return null; // on error does not modify appstate
    }
  }

  @override 
  void before() => dispatch(WaitAction.add("delete_review_report"));

  @override 
  void after() => dispatch(WaitAction.remove("delete_review_report"));
 }

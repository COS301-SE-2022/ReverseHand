import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/app_management/get_user_reports_action.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class RemoveUserReportAction extends ReduxAction<AppState> {
  final String reportId;
  final String userId;
  final bool issueWarning;

  RemoveUserReportAction({
    required this.reportId,
    required this.userId,
    required this.issueWarning,
  });

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation {
      removeUserReport(issueWarning: $issueWarning, report_id: "$reportId", user_id: "$userId") {
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

    debugPrint(graphQLDoc);

    try {
      final response = await Amplify.API.mutate(request: request).response;
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
  void before() {
    dispatch(NavigateAction.pop());
    dispatch(GetUserReportsAction());
  }
}

// mutation {
//       removeUserReport(issueWarning: false, report_id: "report#deefec89-7689-4abe-b179-b86b63c872eb", user_id: "t#acff077a-8855-4165-be78-090fda375f90") {
//         description
//         reason
//         reported_user {
//           id
//         }
//         reporter_user {
//           id
//         }
//       }
//     }
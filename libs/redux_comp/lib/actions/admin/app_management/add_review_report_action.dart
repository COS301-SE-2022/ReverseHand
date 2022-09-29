import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AddReviewReportAction extends ReduxAction<AppState> {
  final String userId;
  final String reviewId;
  final ReportDetailsModel report;

  AddReviewReportAction({required this.reviewId, required this.userId, required this.report});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''
      mutation {
        addReviewReport(report: ${report.toJson(false)}, user_id: "$userId", review_id: "$reviewId") {
          description
          reason
          reporter_user {
            id
            name
          }
        }
      }
    ''';

    final request = GraphQLRequest(
      document: graphQLDoc,
    );

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
}

//       mutation {
//         addUserReport(report: {
//       reason: "reason",
//       description: "description",
//       reported_user: {
//         id: "t#acff077a-8855-4165-be78-090fda375f90",
//         name: "Alexander",
//       }
//     }, user_details: {
//       id : "c#983b506a-8ac3-4ca0-9844-79ed15291cd5",
//       name : "Richard",
//     }) {
//           description
//           reason
//           reported_user {
//             id
//             name
//           }
//           reporter_user {
//             id
//             name
//           }
//         }
//       }
// 
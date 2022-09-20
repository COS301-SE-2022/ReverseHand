import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AddAdvertReportAction extends ReduxAction<AppState> {
  final String advertId;
  final String userId;
  final ReportDetailsModel report;

  AddAdvertReportAction({
    required this.advertId,
    required this.userId,
    required this.report,
  });

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation {
      addAdvertReport(advert_id: "$advertId", user_id: "$userId", report: ${report.toJson(false)}) {
        count
      }
    }''';
    
    debugPrint(graphQLDoc);

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
}


// mutation MyMutation {
//   addAdvertReport(advert_id: "", user_id: "", report: {description: "", reason: "", reporter_user: {id: "", name: ""}}) {
//     advert {
//       id
//       title
//     }
//     count
//     customer_id
//     reports {
//       description
//       reason
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/app_management/get_reported_adverts_action.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AcceptAdvertReportAction extends ReduxAction<AppState> {
  final bool issueWarning;
  final String advertId;

  AcceptAdvertReportAction(
      {required this.advertId, required this.issueWarning});
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation MyMutation {
      acceptAdvertReport(advert_id: "$advertId", issueWarning: $issueWarning) {
        id
      }
    }
    ''';

    final request = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      /*final response = */ await Amplify.API.mutate(request: request).response;
      // debugPrint(response.data);
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
    dispatch(GetReportedAdvertsAction());
  }
}

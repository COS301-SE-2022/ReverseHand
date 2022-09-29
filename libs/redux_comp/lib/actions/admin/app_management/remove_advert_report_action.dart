import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/app_management/get_reported_adverts_action.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class RemoveAdvertReportAction extends ReduxAction<AppState> {
  String advertId, tradesmanId;

  RemoveAdvertReportAction({required this.advertId, required this.tradesmanId});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''
      mutation {
        removeAdvertReport(advert_id: "$advertId", tradesman_id: "$tradesmanId") {
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

  @override
  void before() {
    dispatch(WaitAction.add("remove-advert"));
  }

  @override
  void after() {
    dispatch(GetReportedAdvertsAction());
    dispatch(WaitAction.remove("remove-advert"));
  }
}

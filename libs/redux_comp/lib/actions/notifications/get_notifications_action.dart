import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

// gets all notifications for a user
class GetNotificationsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = ''' query {
      getNotifications(user_id: ${state.userDetails!.id}) {
        title
        msg
        type
        timestamp
      }
    }
    ''';

    final requestUserGroup = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      final response =
          await Amplify.API.query(request: requestUserGroup).response;
      final data = response.data['getNotifications'];

      return null;
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}

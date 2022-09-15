import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/get_notifications_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SubscribeNotificationsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''subscription {
      notifyNewNotifications(user_id: "${state.userDetails.id}") {
        user_id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final Stream<GraphQLResponse<dynamic>> operation = Amplify.API.subscribe(
        request,
        onEstablished: () =>
            debugPrint('Notifications Subscription established'),
      );

      /* StreamSubscription<GraphQLResponse<dynamic>> subscription = */
      operation.listen(
        (event) => dispatch(GetNotificationsAction()),
        onError: (Object e) =>
            debugPrint('Error in notifications subscription stream: $e'),
      );

      return null;
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

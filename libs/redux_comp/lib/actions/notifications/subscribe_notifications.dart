import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SubscribNotificationsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''subscription {
      getNotificatoinUpdates(user_id: "${state.userDetails!.id}") {
        title
        msg
        type
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final Stream<GraphQLResponse<dynamic>> operation = Amplify.API.subscribe(
        request,
        onEstablished: () => debugPrint('Subscription established'),
      );

      /* StreamSubscription<GraphQLResponse<dynamic>> subscription = */
      operation.listen(
        (event) => print("todo"),
        onError: (Object e) => debugPrint('Error in subscription stream: $e'),
      );

      return null;
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

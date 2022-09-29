import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'get_messages_action.dart';

class SubscribMessagesAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    state.messageSubscription?.cancel();

    String graphQLDocument = '''subscription {
      getMessageUpdates(chat_id: "${state.chat!.id}") {
        id
        chat_id
        msg
        sender
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
      StreamSubscription<GraphQLResponse<dynamic>> subscription =
          operation.listen(
        (event) => dispatch(GetMessagesAction()),
        onError: (Object e) => debugPrint('Error in subscription stream: $e'),
      );

      return state.copy(messageSubscription: subscription);
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  // in after dispatch action to create subscription
}

import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'get_chats_action.dart';

class SubscribMessagesAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final String userType = state.userDetails!.userType;

    String graphQLDocument = '''subscription {
      getMessageUpdates$userType(${userType.toLowerCase()}_id: "${state.userDetails!.id}") {
        consumer_id
        tradesman_id
        msg
        sender
        timestamp
        name
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
        (event) => dispatch(GetChatsAction()),
        onError: (Object e) => debugPrint('Error in subscription stream: $e'),
      );

      return null;
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  // in after dispatch action to create subscription
}

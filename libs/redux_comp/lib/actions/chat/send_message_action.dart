import 'dart:async';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SendMessageAction extends ReduxAction<AppState> {
  final String msg;

  SendMessageAction(this.msg);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      sendMessage(c_id: "${state.chat.consumerId}", t_id: "${state.chat.tradesmanId}", msg: "$msg", sender: "${state.userDetails!.userType.toLowerCase()}", name: "${state.userDetails!.name}") {
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
      /* final response = */ await Amplify.API
          .mutate(request: request)
          .response;

      return null;
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  // in after dispatch action to create subscription
}

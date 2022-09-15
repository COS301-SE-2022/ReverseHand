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
      sendMessage(chat_id: "${state.chat!.id}", msg: "$msg", sender: "${state.userDetails.userType.toLowerCase()}") {
        id
        chat_id
        msg
        sender
        timestamp
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

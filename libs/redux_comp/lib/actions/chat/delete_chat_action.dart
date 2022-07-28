import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class DeleteChatAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      deleteChat(c_id: "${state.userDetails!.id}", ad_id: "${state.activeAd!.id}") {
        consumer_id
        tradesman_id
        consumer_name
        tradesman_name
        messages {
          msg
          sender
          timestamp
          name
        }
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

  @override
  void after() => dispatch(GetChatsAction());
}

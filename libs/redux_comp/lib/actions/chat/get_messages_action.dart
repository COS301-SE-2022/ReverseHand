import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetMessagesAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getMessages(chat_id: "${state.chat!.id}") {
        id
        chat_id
        msg
        sender
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      dynamic data = jsonDecode(response.data)['getChats'];
      List<MessageModel> messages =
          data.map((el) => MessageModel.fromJson(el)).toList();

      return state.copy(
        messages: messages,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

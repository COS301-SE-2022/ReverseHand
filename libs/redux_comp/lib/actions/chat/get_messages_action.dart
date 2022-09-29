import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetMessagesAction extends ReduxAction<AppState> {
  final ChatModel? chat; // chat for which to get messages

  GetMessagesAction({this.chat});

  @override
  Future<AppState?> reduce() async {
    final ChatModel current = chat ?? state.chat!;

    String graphQLDocument = '''query {
      getMessages(chat_id: "${current.id}") {
        id
        chat_id
        msg
        sender
        timestamp
        sentiment
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<dynamic> data = jsonDecode(response.data)['getMessages'];
      List<MessageModel> messages =
          data.map((el) => MessageModel.fromJson(el)).toList();

      return state.copy(messages: messages, chat: current);
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() => dispatch(WaitAction.add("get_messages"));

  @override
  void after() => dispatch(WaitAction.remove("get_messages"));
}

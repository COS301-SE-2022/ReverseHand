import 'dart:async';
import 'dart:convert';
import 'package:redux_comp/models/chat/chat_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetChatsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // if (state.chats.isNotEmpty) return null;

    String graphQLDocument = '''query {
      get${state.userDetails!.userType}Chats(user_id: "${state.userDetails!.id}") {
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
      final response = await Amplify.API.query(request: request).response;

      List<ChatModel> chats = [];
      dynamic data =
          jsonDecode(response.data)['get${state.userDetails!.userType}Chats'];

      ChatModel chat = state.chat;

      data.forEach((el) {
        ChatModel c = ChatModel.fromJson(el);
        if (c.consumerId == state.chat.consumerId &&
            c.tradesmanId == state.chat.tradesmanId) chat = c;

        return chats.add(c);
      });

      return state.copy(
        chats: chats,
        chat: chat,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() {
    // if there are currently chats the user may be viewing them and if a
    // new one comes in we don't want to hide everything and display a loading icon
    if (state.chats.isEmpty) dispatch(WaitAction.add("get_chats"));
  }

  @override
  void after() => dispatch(WaitAction.remove("get_chats"));
}

import 'dart:async';
import 'dart:convert';
import 'package:redux_comp/models/chat/chat_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetChatsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getChats(user_id: "${state.userDetails.id}") {
        id
        other_user_id
        consumer_name
        tradesman_name
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      final List<dynamic> data = jsonDecode(response.data)['getChats'];
      List<ChatModel> chats = data.map((el) => ChatModel.fromJson(el)).toList();

      return state.copy(
        chats: chats,
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

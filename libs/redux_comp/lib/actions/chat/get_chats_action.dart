import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetChatsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // if (state.chats.isNotEmpty) return null;

    // String graphQLDocument = '''query {
    //   getConsumerChats(c_id: "${state.userDetails!.id}") {
    //     consumer_id
    //     tradesman_id
    //     messages {
    //       msg
    //       sender
    //       timestamp
    //     }
    //   }
    // }''';
    String graphQLDocument = '''query {
      getConsumerChats(c_id: "c#001") {
        consumer_id
        tradesman_id
        messages {
          msg
          sender
          timestamp
        }
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<ChatModel> chats = [];
      dynamic data = jsonDecode(response.data)['getConsumerChats'];

      data.forEach((el) => chats.add(ChatModel.fromJson(el)));

      return state.copy(
        chats: chats,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  // in after dispatch action to create subscription
}

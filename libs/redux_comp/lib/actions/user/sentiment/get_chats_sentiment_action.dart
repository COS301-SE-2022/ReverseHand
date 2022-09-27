import 'dart:convert';

import 'package:redux_comp/models/chat/chat_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetChatsSentimentAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getChatsSentiment {
        id
        other_user_id
        consumer_name
        tradesman_name
        timestamp
        sentiment {
          negative
          negative_messages
          neutral_messages
          positive
          positive_messages
        }
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;
      final List<dynamic> data = jsonDecode(response.data)['getChatsSentiment'];

      return state.copy(
        chats: data.map((e) => ChatModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

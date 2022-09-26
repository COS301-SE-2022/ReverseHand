import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SendMessageAction extends ReduxAction<AppState> {
  final String msg;

  SendMessageAction(this.msg);

  @override
  Future<AppState?> reduce() async {
    final SentimentResult analysis = Sentiment.analysis(msg, emoji: true);
    debugPrint(analysis.toString());

    String graphQLDocument = '''mutation {
      sendMessage(chat_id: "${state.chat!.id}", msg: "$msg", sender: "${state.userDetails.userType.toLowerCase()}", sender_id: "${state.userDetails.id}", reciever_id: "${state.chat!.otherUserId}", sentiment: ${analysis.score}) {
        id
        chat_id
        msg
        sender
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;
      debugPrint(response.data);

      MessageModel message =
          MessageModel.fromJson(jsonDecode(response.data)['sendMessage']);

      List<MessageModel> messages = state.messages;
      messages.add(message);

      return state.copy(messages: messages);
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  // in after dispatch action to create subscription
}

/*
mutation {
      sendMessage(chat_id: "chat#a#d52e5cf2-7855-48d2-b9a2-83c03494ed2d", msg: "I love this idea", sender: "consumer", sender_id: "c#983b506a-8ac3-4ca0-9844-79ed15291cd5", reciever_id: "t#acff077a-8855-4165-be78-090fda375f90", sentiment: 3.0) {
        id
        chat_id
        msg
        sender
        timestamp
      }
    }
    */

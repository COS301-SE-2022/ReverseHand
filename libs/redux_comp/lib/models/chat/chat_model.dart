import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/chat/message_model.dart';

@immutable
class ChatModel {
  final String consumerId;
  final String tradesmanId;
  final List<MessageModel> messages;

  const ChatModel({
    required this.consumerId,
    required this.tradesmanId,
    required this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        consumerId: json['consumer_id'],
        tradesmanId: json['tradesman_id'],
        messages: (json['messages'] as List)
            .map((el) => MessageModel.fromJson(el))
            .toList(),
      );
}

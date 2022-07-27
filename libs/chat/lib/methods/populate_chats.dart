import 'package:async_redux/async_redux.dart';
import 'package:chat/widgets/quick_view_chat_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';

List<Widget> populateChats(List<ChatModel> chats, Store<AppState> store) {
  List<Widget> widgets = [];

  for (ChatModel chat in chats) {
    widgets.add(
      QuickViewChatWidget(
        store: store,
        chat: chat,
      ),
    );
  }

  return widgets;
}

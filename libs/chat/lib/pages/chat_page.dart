// the actual chat between 2 user

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/chat/message_model.dart';

class ChatPage extends StatelessWidget {
  final Store<AppState> store;

  const ChatPage({required this.store, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                List<Text> messages = [];

                for (MessageModel msg in vm.chat.messages) {
                  messages.add(Text(
                    msg.msg,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ));
                }

                return Column(
                  children: messages,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        chat: state.chat,
      );
}

// view model
class _ViewModel extends Vm {
  final ChatModel chat;

  _ViewModel({
    required this.chat,
  }); // implementinf hashcode
}

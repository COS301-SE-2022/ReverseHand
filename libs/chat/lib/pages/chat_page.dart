// the actual chat between 2 user

import 'package:async_redux/async_redux.dart';
import 'package:chat/widgets/chat_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/actions/chat/send_message_action.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import '../widgets/action_bar_widget.dart';
import '../widgets/message_tile_widget.dart';

class ChatPage extends StatelessWidget {
  final Store<AppState> store;

  const ChatPage({required this.store, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          List<Widget> messages = [];

          for (MessageModel msg in vm.chat.messages) {
            if (vm.currentUser == msg.sender) {
              messages.add(
                MessageOwnTileWidget(
                  message: msg,
                ),
              );
            } else {
              messages.add(
                MessageTileWidget(
                  message: msg,
                ),
              );
            }
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  const ChatAppBarWidget(title: "Name"),
                  //********************************************************//
                  // const DateLabelWidget(label: "Yesterday"), //todo michael

                  //todo michael
                  ...messages,
                ],
              ),
            ),
            //************************NAVBAR***********************/

            bottomSheet: ActionBarWidget(
              onPressed: vm.dispatchSendMsgAction,
            ),

            //*****************************************************/
          );
        },
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSendMsgAction: (String msg) => dispatch(SendMessageAction(msg)),
        chat: state.chat,
        currentUser: state.userDetails!.userType.toLowerCase(),
      );
}

// view model
class _ViewModel extends Vm {
  final ChatModel chat;
  final String currentUser;
  final void Function(String msg) dispatchSendMsgAction;

  _ViewModel({
    required this.dispatchSendMsgAction,
    required this.chat,
    required this.currentUser,
  }) : super(equals: [chat]); // implementinf hashcode
}

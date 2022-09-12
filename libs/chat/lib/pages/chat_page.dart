// the actual chat between 2 user

import 'package:async_redux/async_redux.dart';
import 'package:chat/widgets/chat_appbar_widget.dart';
import 'package:flutter/material.dart';
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
    final ScrollController scrollController = ScrollController();

    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.chat == null) return Container();

          List<Widget> messages = [];

          for (MessageModel msg in vm.messages) {
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

          // setting scroll
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.ease,
                );
              }
            },
          );

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                ChatAppBarWidget(
                    title: vm.currentUser == "consumer"
                        ? vm.chat!.tradesmanName
                        : vm.chat!.consumerName,
                    store: store),
                SliverToBoxAdapter(
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            // const DateLabelWidget(label: "Yesterday"), //todo michael
                            const Padding(
                              padding: EdgeInsets.only(top: 35),
                            ),
                            ...messages,
                            const Padding(
                              padding: EdgeInsets.only(bottom: 80),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
        messages: state.messages,
      );
}

// view model
class _ViewModel extends Vm {
  final ChatModel? chat;
  final List<MessageModel> messages;
  final String currentUser;
  final void Function(String msg) dispatchSendMsgAction;

  _ViewModel({
    required this.dispatchSendMsgAction,
    required this.chat,
    required this.currentUser,
    required this.messages,
  }) : super(equals: [chat, messages]); // implementinf hashcode
}

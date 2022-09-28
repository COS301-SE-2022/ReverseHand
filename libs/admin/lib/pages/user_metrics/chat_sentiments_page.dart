import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import '../../widgets/message_tile_widget.dart';
import '../../widgets/sentiment_chat_appbar_widget.dart';

// the actual chat between 2 user

class ChatSentimentsPage extends StatelessWidget {
  final Store<AppState> store;

  const ChatSentimentsPage({required this.store, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.chat == null) return Container();

          List<Widget> messages = [];

          for (MessageModel msg in vm.messages) {
            if (msg.sender == 'consumer') {
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
            body: CustomScrollView(
              slivers: [
                SentimentChatAppBarWidget(
                  title: "Chat Analysis",
                  store: store,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 35),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Chat between: \n${vm.chat!.consumerName} /  ${vm.chat!.tradesmanName}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
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
          );
        },
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatSentimentsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        chat: state.chat,
        messages: state.messages,
        currentUser: state.userDetails.userType.toLowerCase(),
      );
}

// view model
class _ViewModel extends Vm {
  final ChatModel? chat;
  final List<MessageModel> messages;
  final String currentUser;

  _ViewModel({
    required this.chat,
    required this.messages,
    required this.currentUser,
  }) : super(equals: [chat, messages]);
}

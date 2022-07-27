// the actual chat between 2 user

import 'package:async_redux/async_redux.dart';
import 'package:chat/widgets/chat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/navbar.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/chat/message_model.dart';

import '../widgets/action_bar_widget.dart';
import '../widgets/message_tile.dart';
import '../widgets/date_label_widget.dart';

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
                List<MessageOwnTileWidget> ownMessages = [];
                List<MessageTileWidget> messages = [];

                for (MessageModel msg in vm.chat.messages) {
                  if(vm.currentUser == msg.sender) {
                    ownMessages.add(
                      MessageOwnTileWidget(
                        message: msg.msg,
                      ),
                    );
                  }
                  else {
                    messages.add(
                      MessageTileWidget(
                        message: msg.msg,
                      ),
                    );
                  }
                }

                return Column(
                      children: [
                        //*******************APP BAR WIDGET*********************//
                        const ChatAppBarWidget(title: "Name"),
                        //********************************************************//
                        // const DateLabelWidget(label: "Yesterday"), //todo michael

                        //todo michael
                        ...ownMessages,
                        ...messages,

                      ],
                );
              },
            ),
          ),

          //************************NAVBAR***********************/
          bottomSheet: const ActionBarWidget(),
           bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*****************************************************/
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
        currentUser: state.userDetails!.userType.toLowerCase(),
      );
}

// view model
class _ViewModel extends Vm {
  final ChatModel chat;
  final String currentUser;

  _ViewModel({
    required this.chat,
    required this.currentUser,
  }); // implementinf hashcode
}

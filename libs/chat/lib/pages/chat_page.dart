// the actual chat between 2 user

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/navbar.dart';
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
                    msg.sender,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ));
                }

                return Column(
                  children: const [
                  //*******************APP BAR WIDGET*********************//
                    AppBarWidget(title: "Name Here"),
                    //********************************************************//
                    // messages,
                  ],
                );
              },
            ),
          ),
           //************************NAVBAR***********************/

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

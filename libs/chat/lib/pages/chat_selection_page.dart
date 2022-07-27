// the page in which chats can be selected

import 'package:async_redux/async_redux.dart';
import 'package:chat/methods/populateChats.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';

import '../widgets/QuickViewChatWidget.dart';

class ChatSelectionPage extends StatelessWidget {
  final Store<AppState> store;

  const ChatSelectionPage({Key? key, required this.store}) : super(key: key);

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
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  const AppBarWidget(title: "MY CHATS"),
                  //********************************************************//

                  if (vm.chats.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height) / 3),
                      child: const Text(
                        "There are no\n active chats",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Colors.white54),
                      ),
                    )
                  else
                    ...populateChats(vm.chats, store)
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatSelectionPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        chats: state.chats,
      );
}

// view model
class _ViewModel extends Vm {
  final List<ChatModel> chats;

  _ViewModel({
    required this.chats,
  }) : super(equals: [chats]); // implementinf hashcode
}

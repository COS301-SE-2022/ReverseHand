// the page in which chats can be selected

import 'package:async_redux/async_redux.dart';
import 'package:chat/methods/populate_chats.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:tradesman/widgets/tradesman_navbar_widget.dart';

class ChatSelectionPage extends StatelessWidget {
  final Store<AppState> store;

  const ChatSelectionPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Column(
            children: [
              //*******************APP BAR WIDGET*********************//
              AppBarWidget(title: "MY CHATS", store: store),
              //********************************************************//

              if (vm.loading)
                const LoadingWidget(topPadding: 50, bottomPadding: 0),
              
              ListRefreshWidget(
                widgets: [
                  if (vm.chats.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height) / 3,
                          left: 40,
                          right: 40),
                      child: Text(
                        vm.userType == "consumer"
                            ? "There are no active chats. Accept a bid from a contractor to start a chat with them."
                            : "There are no active chats. Once a client has accepted your bid, a chat will be displayed here.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.white70),
                      ),
                    )
                  else
                    ...populateChats(vm.chats, store)
                ],
                refreshFunction: vm.dispatchGetChatsAction,
              ),
            ],
          ),
        ),
        bottomNavigationBar: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              (vm.userType == "consumer")
                  ? NavBarWidget(
                      store: store,
                    )
                  : TNavBarWidget(store: store),
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
        userType: state.userDetails.userType.toLowerCase(),
        loading: state.wait.isWaiting,
        change: state.change,
        dispatchGetChatsAction: () => dispatch(GetChatsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final List<ChatModel> chats;
  final String userType;
  final bool loading;
  final bool change;
  final VoidCallback dispatchGetChatsAction;

  _ViewModel({
    required this.chats,
    required this.dispatchGetChatsAction,
    required this.userType,
    required this.loading,
    required this.change,
  }) : super(equals: [chats, userType, loading, change]);
}

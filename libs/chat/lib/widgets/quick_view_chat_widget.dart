import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/chat/get_messages_action.dart';
import 'package:redux_comp/actions/chat/subscribe_messages_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';

class QuickViewChatWidget extends StatelessWidget {
  final ChatModel chat;
  final Store<AppState> store;

  const QuickViewChatWidget({
    required this.store,
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => InkWell(
          onTap: () => vm.dispatchGetMessagesAction(chat),
          child: SizedBox(
            width: 400,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                margin: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 220, 224, 230),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: chat.image == null
                            ? const AssetImage(
                                "assets/images/profile.png",
                                package: 'general',
                              )
                            : Image.network(chat.image!).image,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 15)),
                      Text(
                        vm.userType == "Consumer"
                            ? chat.tradesmanName
                            : chat.consumerName,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(7, 10, 13, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, QuickViewChatWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchGetMessagesAction: (ChatModel chat) async {
          await dispatch(GetMessagesAction(chat: chat));
          dispatch(SubscribMessagesAction());
          dispatch(NavigateAction.pushNamed('/chats/chat'));
        },
        userType: state.userDetails.userType,
      );
}

// view model
class _ViewModel extends Vm {
  final Future<void> Function(ChatModel chat) dispatchGetMessagesAction;
  final String userType;

  _ViewModel({
    required this.userType,
    required this.dispatchGetMessagesAction,
  });
}

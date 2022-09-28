import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/chat/chat_model.dart';

class SentimentChatAppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const SentimentChatAppBarWidget({Key? key, required this.title, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => SliverAppBar(
          pinned: true,
          backgroundColor: Theme.of(context).primaryColorDark,
          flexibleSpace: FlexibleSpaceBar(
            title: GestureDetector(
              onTap: vm.dispatchGetOtherUserAction,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 40),
                    child: Align(
                      alignment: Alignment.topRight,
                      child:SizedBox( 
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, SentimentChatAppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
        dispatchGetOtherUserAction: () =>
            dispatch(GetOtherUserAction(state.chat!.otherUserId)),
        chat: state.chat!,
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final ChatModel chat;
  final VoidCallback dispatchGetOtherUserAction;

  _ViewModel({
    required this.popPage,
    required this.dispatchGetOtherUserAction,
    required this.chat,
  }) : super(equals: [chat]);
}

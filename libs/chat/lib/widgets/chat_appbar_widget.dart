import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ChatAppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const ChatAppBarWidget({Key? key, required this.title, required this.store}) : super(key: key);

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
                title: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 40,),
                        child: GestureDetector(
                        onTap: () { }, //todo, link profile
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage("assets/images/profile.png",
                                  package: 'general'),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 10, top: 40),
                      child: Text(
                        title, 
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatAppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;

  _ViewModel({
    required this.popPage,
  });

}

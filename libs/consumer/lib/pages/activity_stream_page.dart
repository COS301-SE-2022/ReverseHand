import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/models/user_models/notification_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/notification_card_widget.dart';

class ConsumerActivityStream extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerActivityStream({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                List<NotificationCardWidget> notificationWidgets =
                    vm.notifications
                        .map(
                          (e) => NotificationCardWidget(
                            titleText: e.title,
                            msg: e.msg,
                            date: timeSinceTimestamp(e.timestamp),
                          ),
                        )
                        .toList();

                return Column(
                  children: [
                    //*******************APP BAR WIDGET*********************//
                    AppBarWidget(title: "ACTIVITY STREAM", store: store),
                    //********************************************************//

                    const Padding(padding: EdgeInsets.only(top: 20)),

                    //*******************MOCK NOTIFICATIONS CARDS*********************//
                    ...notificationWidgets

                    //********************************************************//
                  ],
                );
              }),
        ),

        //************************NAVBAR***********************
        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
        //*****************************************************/
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, ConsumerActivityStream> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        notifications: state.notifications,
      );
}

// view model
class _ViewModel extends Vm {
  final List<NotificationModel> notifications;

  _ViewModel({
    required this.notifications,
  }) : super(equals: [notifications]);
}

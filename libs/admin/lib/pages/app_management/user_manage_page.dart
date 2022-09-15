import 'package:admin/widgets/admin_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class UserManagePage extends StatelessWidget {
  final Store<AppState> store;
  const UserManagePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "User Management",
              store: store,
              backButton: true,
            );
            return (vm.loading)
                ? Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,
                      //*******************************************//

                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  )
                : Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,
                      AdminUserWidget(user: vm.activeUser),
                      const Padding(padding: EdgeInsets.only(bottom: 50)),
                      LongButtonWidget(
                        text: (vm.activeUser.enabled)
                            ? "Disable User"
                            : "Enable User",
                        function: (vm.activeUser.enabled) ? () {} : () {},
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      TransparentLongButtonWidget(
                          text: "Delete User",
                          borderColor: Colors.red,
                          function: () {})
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, UserManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      loading: state.wait.isWaiting,
      activeUser: state.admin.adminManage.activeUser!);
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final AdminUserModel activeUser;

  _ViewModel({
    required this.loading,
    required this.activeUser,
  }) : super(equals: [loading, activeUser]); // implementinf hashcode;
}

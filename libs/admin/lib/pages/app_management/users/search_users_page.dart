import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/quickview_user_widget.dart';
import 'package:admin/widgets/search_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class SearchUsersPage extends StatelessWidget {
  final Store<AppState> store;

  const SearchUsersPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "List Users",
              store: store,
              backButton: true,
            );
            List<QuickViewUserCardWidget> userWidgets = [];
            for (var user in vm.users) {
              userWidgets.add(QuickViewUserCardWidget(store: store, user: user));
            }
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
                      const SearchWidget(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("//lowkey want a tabbed view//"),
                          DropDownOptionsWidget(
                              title: "Group",
                              functions: {
                                "Customer": () {},
                                "Tradesman": () {},
                              },
                              currentItem: "Customer"),
                        ],
                      ),

                      ...userWidgets
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, SearchUsersPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      loading: state.wait.isWaiting,
      users: state.admin.adminManage.usersList?.users ?? []);
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<CognitoUserModel> users;

  _ViewModel({
    required this.loading,
    required this.users,
  }) : super(equals: [loading, users]); // implementinf hashcode;
}

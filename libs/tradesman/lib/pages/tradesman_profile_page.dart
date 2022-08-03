import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/profile_divider.dart';

import '../widgets/navbar.dart';

class TradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanProfilePage({Key? key, required this.store}) : super(key: key);

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
              builder: (BuildContext context, _ViewModel vm) =>
                  Column(children: [
                //**************HEADING***************/
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text(
                      (vm.userDetails.name != null)
                          ? vm.userDetails.name!
                          : "null",
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                //************************************/

                //****************ICON****************/
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
                //************************************/

                //************NAME*******************/
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 40),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 26.0,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                        (vm.userDetails.name != null)
                            ? vm.userDetails.name!
                            : "null",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                //************************************/

                const ProfileDividerWidget(),

                //************CELL*******************/
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.white70,
                        size: 26.0,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                          (vm.userDetails.cellNo != null)
                              ? vm.userDetails.cellNo!
                              : "null",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ),
                //************************************/

                const ProfileDividerWidget(),

                //************EMAIl*******************/
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Colors.white70,
                        size: 26.0,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      Text(vm.userDetails.email,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ),
                //************************************/

                const ProfileDividerWidget()
              ]),
            ),
          ),
          //****************NAVBAR****************/
          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
          //**************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, TradesmanProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      userDetails: state.userDetails!,
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/edit_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushEditProfilePage;

  _ViewModel({
    required this.pushEditProfilePage,
    required this.userDetails,
  }) : super(equals: [userDetails]);
}

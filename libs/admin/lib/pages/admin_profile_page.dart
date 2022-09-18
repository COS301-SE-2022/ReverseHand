import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/bottom_sheet.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/profile_image.dart';
import 'package:redux_comp/actions/user/amplify_auth/logout_action.dart';
import 'package:redux_comp/actions/user/user_table/edit_user_details_action.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/profile_divider.dart';

class AdminProfilePage extends StatelessWidget {
  final Store<AppState> store;
  final nameController = TextEditingController();
  AdminProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => (vm.isWaiting)
                ? Column(
                    children: [
                      AppBarWidget(title: "PROFILE", store: store),
                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  )
                : Column(
                    children: [
                      //*******************APP BAR WIDGET*********************//
                      AppBarWidget(title: "PROFILE", store: store),
                      //********************************************************//

                      const Padding(padding: EdgeInsets.only(top: 25)),

                      //**************HEADING***************/
                      Center(
                        child: Text(
                          vm.userDetails.name != null
                              ? vm.userDetails.name!
                              : "null",
                          style: const TextStyle(fontSize: 35),
                        ),
                      ),
                      //************************************/
                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 15)),
                      //****************PROFILE IMAGE****************/
                      ProfileImageWidget(
                        store: store,
                      ),
                      //*****************************************

                      //************EMAIL*******************/
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 30, top: 20, bottom: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(vm.userDetails.email,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      //************************************/

                      const ProfileDividerWidget(),

                      //************NAME*******************/
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 26.0,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 8)),
                                Text(
                                  (vm.userDetails.name != null)
                                      ? vm.userDetails.name!
                                      : "null",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return BottomSheetWidget(
                                          text:
                                              "What name would you like to save?",
                                          initialVal: vm.userDetails.name,
                                          controller: nameController,
                                          function: () {
                                            vm.dispatchChangeNameAction(
                                                vm.userDetails.id,
                                                nameController.value.text);
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 15,
                                )),
                          ],
                        ),
                      ),
                      //************************************/
                      const ProfileDividerWidget(),

                      //************LOCATION*****************/
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 26.0,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 8)),
                                Text(
                                    (vm.userDetails.location != null)
                                        ? "${vm.userDetails.location!.address.city}, ${vm.userDetails.location!.address.province}"
                                        : "null",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ],
                            ),
                            IconButton(
                                onPressed: vm.pushLocationSearchPage,
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 15,
                                ))
                          ],
                        ),
                      ),
                      //************************************/

                      const ProfileDividerWidget(),

                      //**********TEMP LOGOUT BUTTON********/
                      IconButton(
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () => vm.dispatchLogoutAction(),
                        splashRadius: 30,
                        highlightColor: Colors.orange,
                        splashColor: Colors.white,
                      ),
                      //************************************/
                      const Padding(padding: EdgeInsets.only(bottom: 50)),
                    ],
                  ),
          ),
        ),

        //************************NAVBAR***********************/

        //*************************************************//
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminProfilePage> {
  _Factory(widget) : super(widget);

  //Just making sure edit page is not necessary before it is removed from viewmodel

  @override
  _ViewModel fromStore() => _ViewModel(
        pushLocationSearchPage: () => dispatch(
          NavigateAction.pushNamed('/geolocation/custom_location_search'),
        ),
        dispatchLogoutAction: () => dispatch(LogoutAction()),
        dispatchChangeNameAction: (String userId, String name) => dispatch(
            EditUserDetailsAction(userId: userId, changed: "name", name: name)),
        userDetails: state.userDetails,
        isWaiting: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final void Function() dispatchLogoutAction;
  final void Function(String, String) dispatchChangeNameAction;
  final VoidCallback pushLocationSearchPage;
  final bool isWaiting;

  _ViewModel({
    required this.pushLocationSearchPage,
    required this.userDetails,
    required this.dispatchLogoutAction,
    required this.dispatchChangeNameAction,
    required this.isWaiting,
  }) : super(equals: [userDetails, isWaiting]);
}

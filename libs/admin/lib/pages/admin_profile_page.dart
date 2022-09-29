import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/provinces_widget.dart';
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

class AdminProfilePage extends StatefulWidget {
  final Store<AppState> store;

  const AdminProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final nameController = TextEditingController();
  String? province;

  void showRadioSelect() async {
    final String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProvinceSelectWidget();
      },
    );

    // Update UI
    if (result != null) {
      setState(() {
        province = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                if (province != null) {
                  vm.dispatchChangeProvinceAction(vm.userDetails.id, province!);
                  province = null;
                }
                return (vm.isWaiting)
                    ? Column(
                        children: [
                          AppBarWidget(title: "PROFILE", store: widget.store),
                          LoadingWidget(
                              topPadding:
                                  MediaQuery.of(context).size.height / 3,
                              bottomPadding: 0)
                        ],
                      )
                    : Column(
                        children: [
                          //*******************APP BAR WIDGET*********************//
                          AppBarWidget(title: "PROFILE", store: widget.store),
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
                            store: widget.store,
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
                                const Padding(
                                    padding: EdgeInsets.only(right: 8)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
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
                                        (vm.userDetails.scope != null)
                                            ? "${vm.userDetails.scope}"
                                            : "null",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () => showRadioSelect(),
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
                      );
              }),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: widget.store),
        //************************NAVBAR***********************/

        //*************************************************//
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _AdminProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchLogoutAction: () => dispatch(LogoutAction()),
        dispatchChangeNameAction: (String userId, String name) => dispatch(
            EditUserDetailsAction(userId: userId, changed: "name", name: name)),
        dispatchChangeProvinceAction: (String userId, String province) =>
            dispatch(EditUserDetailsAction(
                userId: userId, changed: "scope", scope: province)),
        userDetails: state.userDetails,
        isWaiting: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final void Function() dispatchLogoutAction;
  final void Function(String, String) dispatchChangeNameAction;
  final void Function(String, String) dispatchChangeProvinceAction;
  final bool isWaiting;

  _ViewModel({
    required this.userDetails,
    required this.dispatchLogoutAction,
    required this.dispatchChangeNameAction,
    required this.dispatchChangeProvinceAction,
    required this.isWaiting,
  }) : super(equals: [userDetails, isWaiting]);
}

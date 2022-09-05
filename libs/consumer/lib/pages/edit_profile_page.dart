import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/bottom_sheet.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:redux_comp/actions/user/user_table/create_user_action.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';

// import '../widgets/multiselect_widget.dart';

class EditConsumerProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditConsumerProfilePage({Key? key, required this.store})
      : super(key: key);

  @override
  State<EditConsumerProfilePage> createState() =>
      _EditConsumerProfilePageState();
}

class _EditConsumerProfilePageState extends State<EditConsumerProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cellController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cellController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        nameController = nameController;
      });
    });
    cellController.addListener(() {
      setState(() {
        cellController = cellController;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET******************//
                AppBarWidget(title: "CREATE PROFILE", store: widget.store),
                //***************************************************//

                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return BottomSheetWidget(
                            text: "What name would you like to save?",
                            initialVal: "",
                            controller: nameController,
                            function: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.orange,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              nameController.value.text.isEmpty
                                  ? "Enter your name"
                                  : nameController.value.text,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                          ],
                        ),
                        (nameController.value.text.isEmpty)
                            ? const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              )
                      ],
                    ),
                  ),
                ),
                //**************************************************//

                const ProfileDividerWidget(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return BottomSheetWidget(
                            text: "What phone number ",
                            initialVal: "",
                            controller: cellController,
                            function: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.orange,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              cellController.value.text.isEmpty
                                  ? "Enter your cell"
                                  : cellController.value.text,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                          ],
                        ),
                        (cellController.value.text.isEmpty)
                            ? const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              )
                      ],
                    ),
                  ),
                ),

                const ProfileDividerWidget(),

                InkWell(
                  onTap: vm.pushCustomSearch,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.orange,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            (vm.locationResult == null)
                                ? const Text("Select your location",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70))
                                : Text(
                                    "${vm.locationResult!.address.city}, ${vm.locationResult!.address.province}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white70))
                          ],
                        ),
                        (vm.locationResult == null)
                            ? const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              )
                      ],
                    ),
                  ),
                ),
                //**************************************************//

                const ProfileDividerWidget(),

                const Padding(padding: EdgeInsets.only(bottom: 30)),
                //**************************************************//

                //*******************SAVE BUTTON********************//
                ButtonWidget(
                    text: "Done",
                    function: () {
                      final name = nameController.value.text.trim();
                      final cell = cellController.value.text.trim();
                      if (name.isNotEmpty &&
                          cell.isNotEmpty &&
                          vm.locationResult != null) {
                        vm.dispatchCreateConsumerAction(
                            name, cell, vm.locationResult!);
                      } else {}
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _EditConsumerProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchCreateConsumerAction:
            (String name, String cellNo, Location location) => dispatch(
          CreateUserAction(
            name: name,
            cellNo: cellNo,
            location: location,
          ),
        ),
        pushCustomSearch: () => dispatch(
          NavigateAction.pushNamed('/geolocation/custom_location_search'),
        ),
        isRegistered: state.userDetails!.registered!,
        locationResult: state.locationResult,
        userDetails: state.userDetails,
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, Location) dispatchCreateConsumerAction;
  final VoidCallback pushCustomSearch;
  final bool isRegistered;
  final Location? locationResult;
  final UserModel? userDetails;

  _ViewModel({
    required this.dispatchCreateConsumerAction,
    required this.pushCustomSearch,
    required this.userDetails,
    required this.locationResult,
    required this.isRegistered,
  }) : super(equals: [userDetails]);
}

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cellController = TextEditingController();

  bool _nameValid = false;
  bool _cellValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cellController.dispose();
    super.dispose();
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
                            controller: _nameController,
                            function: () {
                              vm.popPage();

                              String name = _nameController.value.text;
                              if (!RegExp(r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$")
                                      .hasMatch(name) ||
                                  name.isEmpty) {
                                _nameValid = false;
                              } else {
                                _nameValid = true;
                              }

                              setState(() {});
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
                              _nameController.value.text.isEmpty
                                  ? "Enter your name"
                                  : _nameController.value.text,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                          ],
                        ),
                        _nameValid
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              )
                            : const Icon(
                                Icons.close,
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
                            controller: _cellController,
                            function: () {
                              vm.popPage();

                              final cell = _cellController.value.text.trim();
                              if (!RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                      .hasMatch(cell) ||
                                  cell.isEmpty) {
                                _cellValid = false;
                              } else {
                                _cellValid = true;
                              }

                              setState(() {});
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
                              _cellController.value.text.isEmpty
                                  ? "Enter your cell"
                                  : _cellController.value.text,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                          ],
                        ),
                        _cellValid
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              )
                            : const Icon(
                                Icons.close,
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
                      final name = _nameController.value.text.trim();
                      final cell = _cellController.value.text.trim();
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
        isRegistered: state.userDetails.registered!,
        locationResult: state.locationResult,
        userDetails: state.userDetails,
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, Location) dispatchCreateConsumerAction;
  final void Function() popPage;
  final VoidCallback pushCustomSearch;
  final bool isRegistered;
  final Location? locationResult;
  final UserModel? userDetails;

  _ViewModel({
    required this.dispatchCreateConsumerAction,
    required this.pushCustomSearch,
    required this.popPage,
    required this.userDetails,
    required this.locationResult,
    required this.isRegistered,
  }) : super(equals: [userDetails]);
}

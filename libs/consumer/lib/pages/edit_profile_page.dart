import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/user/user_table/create_user_action.dart';
import 'package:redux_comp/actions/user/user_table/edit_user_details_action.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:uuid/uuid.dart';

class EditProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final cellController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cellController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents floatingActionButton appearing above keyboard
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET******************//
                AppBarWidget(title: "EDIT PROFILE", store: widget.store),
                //***************************************************//

                //**********************NAME************************//
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                  child: TextFieldWidget(
                    initialVal: (widget.store.state.userDetails!.name == null)
                        ? null
                        : widget.store.state.userDetails!.name,
                    label: "name",
                    obscure: false,
                    min: 1,
                    controller: nameController,
                  ),
                ),
                //**************************************************//

                //********************NUMBER**********************//
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: TextFieldWidget(
                    initialVal: (widget.store.state.userDetails!.cellNo == null)
                        ? null
                        : widget.store.state.userDetails!.cellNo,
                    label: "cellphone number",
                    obscure: false,
                    controller: cellController,
                    min: 1,
                  ),
                ),
                //**************************************************//

                //*****************LOCATION BUTTON*******************//
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: TextFieldWidget(
                    label: "location",
                    obscure: false,
                    controller: locationController,
                    onTap: vm.pushCustomSearch,
                    min: 1,
                  ),
                ),
                //**************************************************//

                // /*******************Location Button ****************/

                // ProfileButtonWidget(
                //   function: () {
                //     final sessionToken = const Uuid().v1();
                //     showSearch(
                //         context: context,
                //         delegate: LocationSearchPage(sessionToken, store));
                //   },
                //   height: 60,
                //   icon: null,
                //   text: 'Location',
                //   width: 365,
                // ),

                // const Padding(padding: EdgeInsets.only(bottom: 30)),

                // /**************************************************/

                if (vm.isRegistered) ...[
                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Save Changes",
                      function: () {
                        String? name, cellNo;
                        (vm.userDetails!.name != nameController.value.text)
                            ? name = nameController.value.text
                            : name = null;
                        (vm.userDetails!.cellNo != cellController.value.text)
                            ? cellNo = cellController.value.text
                            : cellNo = null;
                        if (name != null ||
                            cellNo != null ||
                            vm.locationResult != null) {
                          vm.dispatchEditConsumerAction(
                              name, cellNo, vm.locationResult);
                        }
                      }),
                  //**************************************************//

                  const Padding(padding: EdgeInsets.all(8)),
                  ButtonWidget(
                      text: "Discard", color: "dark", function: vm.popPage),
                ] else
                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Save Changes",
                      function: () {
                        final name = nameController.value.text.trim();
                        final cell = cellController.value.text.trim();
                        final location = vm.locationResult;
                        if (location != null) {
                          vm.dispatchCreateConsumerAction(name, cell, location);
                        } else {
                          // thinking maybe we can make a generic dispatch error action with an ErrorTpe parameter
                          // something like:
                          // vm.dispatchError(ErrorType.locationNotCaptured)
                        }
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
class _Factory extends VmFactory<AppState, _EditProfilePageState> {
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
        dispatchEditConsumerAction:
            (String? name, String? cellNo, Location? location) => dispatch(
                EditUserDetailsAction(
                    userId: state.userDetails!.id,
                    name: name,
                    cellNo: cellNo,
                    location: location)),
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushCustomSearch: () => dispatch(
          NavigateAction.pushNamed('/geolocation/custom_location_search',
              arguments: const Uuid().v1()),
        ),
        isRegistered: state.userDetails!.registered!,
        locationResult: state.locationResult,
        userDetails: state.userDetails,
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, Location) dispatchCreateConsumerAction;
  final void Function(String?, String?, Location?) dispatchEditConsumerAction;
  final VoidCallback pushCustomSearch;
  final VoidCallback popPage;
  final bool isRegistered;
  final Location? locationResult;
  final UserModel? userDetails;

  _ViewModel({
    required this.dispatchCreateConsumerAction,
    required this.dispatchEditConsumerAction,
    required this.popPage,
    required this.pushCustomSearch,
    required this.userDetails,
    required this.locationResult,
    required this.isRegistered,
  }) : super(equals: [userDetails]);
}

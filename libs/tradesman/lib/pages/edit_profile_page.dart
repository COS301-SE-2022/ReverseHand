import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/user/create_user_action.dart';
import 'package:redux_comp/actions/user/edit_user_details_action.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';

import '../widgets/multiselect_widget.dart';

class EditTradesmanProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditTradesmanProfilePage({Key? key, required this.store})
      : super(key: key);

  @override
  State<EditTradesmanProfilePage> createState() =>
      _EditTradesmanProfilePageState();
}

class _EditTradesmanProfilePageState extends State<EditTradesmanProfilePage> {
  final nameController = TextEditingController();
  final cellController = TextEditingController();

  //used for multiselect for trade type
  List<String> selectedItems = [];

  void showMultiSelect() async {
    final List<String> items = [
      "Painter",
      "Tiler",
      "Carpenter",
      "Cleaner",
      "Designer",
      "Landscaper",
      "Electrician",
      "Plumber",
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectWidget(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    cellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
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
                      initialVal: vm.userDetails!.name,
                      label: "Name",
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
                      initialVal: vm.userDetails!.cellNo,
                      label: "Phone",
                      obscure: false,
                      controller: cellController,
                      min: 1,
                    ),
                  ),

                  //********************TRADE**********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "Trade",
                      obscure: false,
                      controller: null,
                      onTap: () => showMultiSelect(),
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  //********************DOMAIN**********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "Domains",
                      obscure: false,
                      controller: TextEditingController(),
                      onTap: vm.pushDomainConfirmPage,
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  //**************************************************//

                  //*******************SAVE BUTTON********************//
                  if (vm.userDetails!.registered == true) ...[
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes", function: () {
                          String? name, cellNo;
                          (vm.userDetails!.name != nameController.value.text) ? name = nameController.value.text : null;
                          (vm.userDetails!.cellNo != cellController.value.text) ? cellNo = cellController.value.text : null;
                          vm.dispatchEditTradesmanAction(name, cellNo, vm.userDetails!.domains);
                        }),
                    //**************************************************//

                    const Padding(padding: EdgeInsets.all(8)),
                    ButtonWidget(
                        text: "Discard",
                        color: "dark",
                        function: vm.popPage),
                  ] else
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes",
                        function: () {
                          final name = nameController.value.text.trim();
                          final cell = cellController.value.text.trim();
                          final location = vm.userDetails!.location;
                          final domains = vm.userDetails!.domains;
                          if (location != null || domains.isNotEmpty) {
                            vm.dispatchCreateTradesmanAction(name, cell,
                                ["Painting"], vm.userDetails!.domains);
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
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _EditTradesmanProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchCreateTradesmanAction: (String name, String cell,
                List<String> tradeTypes, List<Domain> domains) =>
            dispatch(CreateUserAction(
          name: name,
          cellNo: cell,
          tradeTypes: tradeTypes,
          domains: domains,
        )),
        dispatchEditTradesmanAction:
            (String? name, String? cell, List<Domain>? domains) =>
                dispatch(EditUserDetailsAction(
          userId: state.userDetails!.id,
          name: name,
          cellNo: cell,
          domains: domains,
        )),
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushDomainConfirmPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/domain_confirm'),
        ),
        userDetails: (state.userDetails == null) ? null : state.userDetails!,
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, List<String>, List<Domain>)
      dispatchCreateTradesmanAction;
  final void Function(String?, String?, List<Domain>?)
      dispatchEditTradesmanAction;
  final VoidCallback popPage;
  final VoidCallback pushDomainConfirmPage;
  final UserModel? userDetails;

  _ViewModel({
    required this.dispatchCreateTradesmanAction,
    required this.dispatchEditTradesmanAction,
    required this.popPage,
    required this.pushDomainConfirmPage,
    required this.userDetails,
  }) : super(equals: [userDetails]);
}

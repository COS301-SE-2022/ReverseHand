import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/bottom_sheet.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:redux_comp/actions/user/user_table/create_user_action.dart';
import 'package:redux_comp/actions/user/user_table/edit_user_details_action.dart';
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
  final tradeController = TextEditingController();

  //used for multiselect for trade type
  List<String> selectedItems = [];

  void showMultiSelect(List<String> selected) async {
    final List<String> items = [
      "Painting",
      "Tiler",
      "Carpenter",
      "Cleaner",
      "Designer",
      "Landscaper",
      "Electrician",
      "Plumbing",
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
    tradeController.dispose();
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
                              controller: nameController);
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
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              nameController.text.isEmpty
                                  ? "Enter your name"
                                  : nameController.text,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                //**************************************************//

                const ProfileDividerWidget(),

                //********************NUMBER**********************//
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                //   child: TextFieldWidget(
                //     initialVal: vm.userDetails!.cellNo,
                //     label: "Phone",
                //     obscure: false,
                //     controller: cellController,
                //     min: 1,
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return BottomSheetWidget(
                              text: "What phone number ",
                              initialVal: "",
                              controller: nameController);
                        });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.phone,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              "Enter your phone number",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),

                const ProfileDividerWidget(),
                //********************TRADE**********************//
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                //   child: TextFieldWidget(
                //     label: "Trade",
                //     obscure: false,
                //     controller: tradeController,
                //     onTap: () => showMultiSelect(vm.userDetails!.tradeTypes),
                //     min: 1,
                //   ),
                // ),
                InkWell(
                  onTap: () => showMultiSelect(vm.userDetails!.tradeTypes),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.construction,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              "Select your trade type(s)",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),

                const ProfileDividerWidget(),
                // display selected items
                // Wrap(
                //   spacing: 8.0,
                //   runSpacing: 8.0,
                //   children: selectedItems
                //       .map((types) => Chip(
                //             labelPadding: const EdgeInsets.all(2.0),
                //             label: Text(
                //               types,
                //               style: const TextStyle(
                //                 color: Colors.white,
                //               ),
                //             ),
                //             backgroundColor:
                //                 const Color.fromRGBO(35, 47, 62, 1),
                //             padding: const EdgeInsets.all(8.0),
                //           ))
                //       .toList(),
                // ),
                //**************************************************//

                //********************DOMAIN**********************//
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                //   child: TextFieldWidget(
                //     label: "Domains",
                //     obscure: false,
                //     controller: TextEditingController(),
                //     onTap: vm.pushDomainConfirmPage,
                //     min: 1,
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    vm.pushDomainConfirmPage();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              "Enter your domain(s)",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
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
                if (vm.userDetails!.registered == true) ...[
                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "save changes",
                      function: () {
                        String? name, cellNo;
                        (vm.userDetails!.name != nameController.value.text)
                            ? name = nameController.value.text
                            : null;
                        (vm.userDetails!.cellNo != cellController.value.text)
                            ? cellNo = cellController.value.text
                            : null;
                        vm.dispatchEditTradesmanAction(name, cellNo,
                            selectedItems, vm.userDetails!.domains);
                      }),
                  //**************************************************//

                  const Padding(padding: EdgeInsets.all(8)),
                  ButtonWidget(
                      text: "Discard", color: "dark", function: vm.popPage),
                ] else
                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Done",
                      function: () {
                        final name = nameController.value.text.trim();
                        final cell = cellController.value.text.trim();
                        final domains = vm.userDetails!.domains;
                        if (domains.isNotEmpty && selectedItems.isNotEmpty) {
                          vm.dispatchCreateTradesmanAction(name, cell,
                              selectedItems, vm.userDetails!.domains);
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
        dispatchEditTradesmanAction: (String? name, String? cell,
                List<String>? tradeTypes, List<Domain>? domains) =>
            dispatch(EditUserDetailsAction(
          userId: state.userDetails!.id,
          name: name,
          cellNo: cell,
          tradeTypes: tradeTypes,
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
  final void Function(String?, String?, List<String>?, List<Domain>?)
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

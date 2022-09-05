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

// import '../widgets/multiselect_widget.dart';

class EditTradesmanProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditTradesmanProfilePage({Key? key, required this.store})
      : super(key: key);

  @override
  State<EditTradesmanProfilePage> createState() =>
      _EditTradesmanProfilePageState();
}

class _EditTradesmanProfilePageState extends State<EditTradesmanProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cellController = TextEditingController();

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
        return MultiSelectWidget(items: items, selectedItems: selectedItems);
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
  void initState() {
    // <- here
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
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> trades = [];
              List<Widget> domains = [];
              for (var i = 0; i < selectedItems.length; i++) {
                {
                  trades.add(Padding(
                    padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            selectedItems.elementAt(i),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ));
                }
              }
              for (var i = 0; i < vm.userDetails.domains.length; i++) {
                {
                  domains.add(Padding(
                    padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${vm.userDetails.domains.elementAt(i).city}, ${vm.userDetails.domains.elementAt(i).province}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ));
                }
              }
              return Column(
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
                    onTap: () => showMultiSelect(selectedItems),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 30, top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.construction,
                                color: Colors.orange,
                                size: 26.0,
                              ),
                              const Padding(padding: EdgeInsets.only(right: 8)),
                              (selectedItems.isEmpty) ? const Text("Select your tradeTypes", style: TextStyle(
                                    fontSize: 18, color: Colors.white70)) : Column(
                                children: [...trades],
                              )
                            ],
                          ),
                          (selectedItems.isEmpty)
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
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.orange,
                                size: 26.0,
                              ),
                              const Padding(padding: EdgeInsets.only(right: 8)),
                             (domains.isEmpty) ? const Text("Select your domains", style:  TextStyle(
                                    fontSize: 18, color: Colors.white70)) : Column(
                                children: [...domains],
                              )
                            ],
                          ),
                          (vm.userDetails.domains.isEmpty)
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
                        final domains = vm.userDetails.domains;
                        if (name.isNotEmpty &&
                            cell.isNotEmpty &&
                            domains.isNotEmpty &&
                            selectedItems.isNotEmpty) {
                          vm.dispatchCreateTradesmanAction(name, cell,
                              selectedItems, vm.userDetails.domains);
                        } else {}
                      }),
                ],
              );
            },
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
          changed: '',
        )),
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushDomainConfirmPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/domain_confirm'),
        ),
        userDetails: state.userDetails!,
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
  final UserModel userDetails;

  _ViewModel({
    required this.dispatchCreateTradesmanAction,
    required this.dispatchEditTradesmanAction,
    required this.popPage,
    required this.pushDomainConfirmPage,
    required this.userDetails,
  }) : super(equals: [userDetails]);
}

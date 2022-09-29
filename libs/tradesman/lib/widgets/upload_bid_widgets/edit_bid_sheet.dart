import 'package:async_redux/async_redux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:general/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/actions/bids/delete_bid_action.dart';
import 'package:redux_comp/actions/bids/edit_bid_action.dart';
import 'package:redux_comp/app_state.dart';

class EditBidSheet extends StatefulWidget {
  final Store<AppState> store;

  const EditBidSheet({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<EditBidSheet> createState() => _EditBidSheetState();
}

class _EditBidSheetState extends State<EditBidSheet> {
  final TextEditingController bidPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var btnText = "Upload Quote";
    return StoreProvider<AppState>(
      store: widget.store,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 390,
          child: Container(
            color: Colors.white70,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //*****************DELETE***************//
                    IconButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Are you sure you want to\ndelete this bid?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StoreConnector<AppState, _ViewModel>(
                                        vm: () => _Factory(this),
                                        builder: (BuildContext context,
                                                _ViewModel vm) =>
                                            ButtonWidget(
                                                text: "Delete",
                                                function: () {
                                                  vm.dispatchDeleteBidAction();
                                                  vm.popPage();
                                                  //after deleting they should go back to advert details
                                                  //or maybe consumer listings?
                                                }),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      ButtonWidget(
                                        text: "Cancel",
                                        color: "light",
                                        border: "lightBlue",
                                        function: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      ),
                    ),
                    //**************************************//

                    //*****************CLOSE****************//
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                    //**************************************//
                  ],
                ),

                //*****************TITLE****************//
                const Text(
                  "Edit Bid",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //**************************************//

                //*****************QUOTE****************//
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(
                    "Add a detailed breakdown of materials and services.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                LongButtonWidget(
                  text: btnText,
                  function: () async {
                    // ignore: unused_local_variable
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                  },
                ),
                //**************************************//

                const Padding(padding: EdgeInsets.only(top: 8)),

                //*****************AMOUNT***************//
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Text(
                    "Enter the final amount for your bid.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                SizedBox(
                  height: 55,
                  width: 180,
                  child: TextFormField(
                    cursorHeight: 30,
                    textAlign: TextAlign.center,
                    cursorColor: Theme.of(context).scaffoldBackgroundColor,
                    style: const TextStyle(color: Colors.black, fontSize: 23),
                    controller: bidPriceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "R",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.orange,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                //**************************************//

                //*****************BUTTONS**************//
                const Padding(padding: EdgeInsets.only(top: 20)),
                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) =>
                      ButtonWidget(
                    text: "Save",
                    function: () {
                      vm.dispatchEditBidAction(
                        price: bidPriceController.value.text.isEmpty
                            ? null
                            : int.parse(bidPriceController.value.text) * 100,
                      );
                      vm.popPage();
                    },
                  ),
                )
                //**************************************//
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, _EditBidSheetState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchDeleteBidAction: () => dispatch(DeleteBidAction()),
        popPage: () => dispatch(NavigateAction.pop()),
        dispatchEditBidAction: ({int? price, String? quote}) =>
            dispatch(EditBidAction(price: price, quote: quote)),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final VoidCallback dispatchDeleteBidAction;
  final void Function({
    String? quote,
    int? price,
  }) dispatchEditBidAction;

  _ViewModel({
    required this.dispatchDeleteBidAction,
    required this.dispatchEditBidAction,
    required this.popPage,
  }); // implementinf hashcode
}

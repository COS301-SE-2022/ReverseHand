import 'package:async_redux/async_redux.dart';
import 'package:general/methods/toast_error.dart';
import 'package:general/methods/toast_success.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/error_type_model.dart';

class UploadAmountSheet extends StatefulWidget {
  const UploadAmountSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadAmountSheet> createState() => _UploadAmountSheetState();
}

class _UploadAmountSheetState extends State<UploadAmountSheet> {
  final TextEditingController bidPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 390,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Place Bid",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              "Step 2:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                  "Enter the final amount for your bid.\n This is a required step.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            SizedBox(
              height: 110,
              width: 250,
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
            StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) =>
                  LongButtonWidget(
                text: "Submit Bid",
                function: () {
                  if (bidPriceController.value.text.isNotEmpty) {
                    final int price =
                        int.parse(bidPriceController.value.text) * 100;
                    displayToastSuccess(
                            context, "Bid Placed!");
                    Navigator.pop(
                      context,
                      price,
                    );
                  } else {
                    displayToastError(context, "Amount must be entered");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _UploadAmountSheetState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {
  _ViewModel();
}

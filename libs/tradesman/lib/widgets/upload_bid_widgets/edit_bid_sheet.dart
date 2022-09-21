import 'package:async_redux/async_redux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:general/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/app_state.dart';

class EditBidSheet extends StatelessWidget {
  final TextEditingController bidPriceController = TextEditingController();
  final Store<AppState> store;

  EditBidSheet({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var btnText = "Upload Quote";
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 370,
        child: Container(
          color: Colors.white70,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //*****************DELETE***************//
                  IconButton(
                    onPressed: () {
                      //are you sure you want to delete this bid
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
                      )),
                  //**************************************//
                ],
              ),

              //*****************TITLE****************//
              const Text(
                "Edit Bid",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              //**************************************//

              //*****************QUOTE****************//
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Text(
                    "Add a detailed breakdown of materials and services.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
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

              const Padding(padding: EdgeInsets.only(top: 20)),

              //*****************AMOUNT***************//
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text("Enter the final amount for your bid.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
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
                  onTap: () {},
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
              ButtonWidget(text: "Save", function: () {})
              //**************************************//
            ],
          ),
        ),
      ),
    );
  }
}

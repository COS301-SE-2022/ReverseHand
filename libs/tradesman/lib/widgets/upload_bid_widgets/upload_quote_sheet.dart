import 'dart:io';

import 'package:authentication/widgets/auth_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:tradesman/widgets/upload_bid_widgets/upload_bid_amount_sheet.dart';

class UploadQuoteSheet extends StatelessWidget {
  const UploadQuoteSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //general shape and shado
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Place Bid",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "Step 1:",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                " Add a detailed breakdown of materials and services.\n You can return to this step later.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: AuthButtonWidget(text: "Upload Quote", function: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if(result != null) {
                //do something here if quote uploaded
              }
            }),
          ),
          ButtonWidget(
              text: "Proceed",
              color: "light",
              border: "lightBlue",
              function: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    builder: (BuildContext context) {
                      return UploadAmountSheet();
                    });
              })
        ],
      ),
    );
  }
}

import 'package:general/widgets/long_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:tradesman/widgets/upload_bid_widgets/upload_bid_amount_sheet.dart';

class UploadQuoteSheet extends StatefulWidget {
  const UploadQuoteSheet({Key? key}) : super(key: key);

  @override
  State<UploadQuoteSheet> createState() => _UploadQuoteSheetState();
}

class _UploadQuoteSheetState extends State<UploadQuoteSheet> {
  @override
  Widget build(BuildContext context) {
    //general shape and shadow
    var btnText = "Upload Quote";

    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context, {'quote': null, 'price': null});
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
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Add a detailed breakdown of materials and services.\n You can return to this step later.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),

          //************************ UPLOAD QUOTE ************** */
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: LongButtonWidget(
              text: btnText,
              function: () async {
                // ignore: unused_local_variable
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                final price = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  builder: (BuildContext context) {
                    return const UploadAmountSheet();
                  },
                );

                // ignore: use_build_context_synchronously
                Navigator.pop(context, {'quote': result, 'price': price});

                //display file name once file chosen, must edit
                // if(result != null) {
                //   // PlatformFile file = result.files.first;
                //   // String fileName = file.name;

                //   setState(() {
                //       btnText = "Uploaded!";
                //   });
                // }
                // else {
                //    setState(() {
                //       btnText = "Upload Quote";
                //   });
                // }
              },
            ),
          ),
          //********************************************************** *

          //**************PROCEED BUTTON ************** */
          ButtonWidget(
            text: "Proceed",
            color: "light",
            border: "lightBlue",
            function: () async {
              final price = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                builder: (BuildContext context) {
                  return const UploadAmountSheet();
                },
              );

              // ignore: use_build_context_synchronously
              Navigator.pop(context, {'quote': null, 'price': price});
            },
          )
          //*************************************** */
        ],
      ),
    );
  }
}

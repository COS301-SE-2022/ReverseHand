
import 'package:general/widgets/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tradesman/methods/currency_formatter.dart';

class UploadAmountSheet extends StatelessWidget {
  final TextEditingController bidController = TextEditingController();

  UploadAmountSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 370,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Text(
              "Step 2:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
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
              height: 100,
              width: 250,
              child: TextFormField(
                cursorHeight: 30,
                textAlign: TextAlign.center,
                cursorColor: Theme.of(context).scaffoldBackgroundColor,
                style: const TextStyle(color: Colors.black, fontSize: 23),
                controller: bidController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                onTap: () {},
                decoration: InputDecoration(
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
            LongButtonWidget(text: "Submit Bid", function: () {})
          ],
        ),
      ),
    );
  }
}

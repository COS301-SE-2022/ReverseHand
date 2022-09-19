// creates a toast with an error message
import 'package:flutter/material.dart';
import 'package:general/widgets/toast_success_widget.dart';

void displayToastSuccess(BuildContext context, String msg) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Colors.orange,
    content: ToastSuccessWidget(msg),
    duration: const Duration(milliseconds: 1000),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

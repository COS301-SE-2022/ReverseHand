import 'package:flutter/material.dart';
import 'package:general/widgets/pop_up.dart';

class DialogHelper {
  static display(context, widget) {
    return showDialog(
      context: context, 
      builder: (context) {
        return PopupCardWidget(popUpWidget: widget);
      },
    );
  }
}
import 'package:consumer/widgets/white_pop_up.dart';
import 'package:flutter/material.dart';

class LightDialogHelper {
  static display(context, widget) {
    return showDialog(
      context: context,
      builder: (context) {
        return WhitePopUpCardWidget(popUpWidget: widget);
      },
    );
  }
}

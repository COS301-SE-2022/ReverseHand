import 'package:flutter/material.dart';

class PopupCardWidget extends StatelessWidget {
  final Widget popUpWidget;
  const PopupCardWidget({
    Key? key,
    required this.popUpWidget,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildPopUp(context, popUpWidget),
    );
  }
  
  _buildPopUp(BuildContext context, Widget widget) {
    return Center(
      child: Container(
        height: 500,
        width: 700,
        decoration: const BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: widget, //call external popup widget
      ),
    );
  }
}
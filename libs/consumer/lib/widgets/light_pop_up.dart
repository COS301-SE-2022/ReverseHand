import 'package:flutter/material.dart';

class LightPopUpCardWidget extends StatelessWidget {
  final Widget popUpWidget;
  const LightPopUpCardWidget({
    Key? key,
    required this.popUpWidget,
  }) : super(key: key);

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
        height: 320,
        // width: 1200,
        margin: const EdgeInsets.only(left: 0, right: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}

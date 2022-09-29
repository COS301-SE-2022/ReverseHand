import 'package:flutter/material.dart';

//used in tradesman and consumer

class PopupCardWidget extends StatelessWidget {
  final Widget popUpWidget;
  final double height;
  const PopupCardWidget({
    Key? key,
    required this.popUpWidget,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildPopUp(context, popUpWidget, height),
    );
  }

  _buildPopUp(BuildContext context, Widget widget, double height) {
    return Center(
      child: Container(
        height: height,
        width: 900,
        margin: const EdgeInsets.only(left: 0, right: 0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(35, 47, 62, 0.97),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        child: Center(child: widget),
      ),
    );
  }
}

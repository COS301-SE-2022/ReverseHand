import 'package:chat/widgets/action_button.dart';
import 'package:flutter/material.dart';

class ActionBarWidget extends StatefulWidget {
  const ActionBarWidget({Key? key}) : super(key: key);

  @override
  ActionBarWidgetState createState() => ActionBarWidgetState();
}

class ActionBarWidgetState extends State<ActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                style: TextStyle(fontSize: 14, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            child: ActionButton(
              color: Color.fromRGBO(243, 157, 55, 1),
              icon: Icons.send_rounded,
              onPressed: null,
            ),
          ),
        ],
      ),
    );
  }
}

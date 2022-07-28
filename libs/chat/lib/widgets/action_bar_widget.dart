import 'package:chat/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class ActionBarWidget extends StatefulWidget {
  final void Function(String msg) onPressed;

  const ActionBarWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  ActionBarWidgetState createState() => ActionBarWidgetState();
}

class ActionBarWidgetState extends State<ActionBarWidget> {
  final TextEditingController msgController = TextEditingController();

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 10),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: msgController,
                style: const TextStyle(fontSize: 17, color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 22,
              right: 5.0,
            ),
            child: ActionButtonWidget(
              color: const Color.fromRGBO(243, 157, 55, 1),
              icon: Icons.send_rounded,
              onPressed: () => widget.onPressed(msgController.value.text),
            ),
          ),
        ],
      ),
    );
  }
}

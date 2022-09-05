import 'package:async_redux/async_redux.dart';
import 'package:chat/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon( //may need to remove
              Icons.camera_alt,
              color: Colors.white,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextField(
                        controller: msgController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            ActionButtonWidget(
              color: const Color.fromRGBO(243, 157, 55, 1),
              icon: Icons.send_rounded,
              onPressed: () {
                widget.onPressed(msgController.value.text);
                msgController.clear();
              },
            ),
          ],
        ),
      ),
    );

  }
}

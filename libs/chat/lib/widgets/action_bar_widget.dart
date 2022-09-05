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
            const Icon(
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
                    const Padding(padding: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(Icons.sentiment_satisfied_alt_outlined), 
                    ),
                    const SizedBox(width: 5),
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
    // return Container(
    //   color: Theme.of(context).scaffoldBackgroundColor,
    //   child: Row(
    //     children: [
    //       //*********************CAMERA ************** */
    //       const Padding(
    //         padding: EdgeInsets.only(left: 30, right: 10),
    //         child: Icon(
    //           Icons.camera_alt,
    //           color: Colors.white,
    //         ),
    //       ),
    //       //***************************************** */
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 16.0),
    //           child: SizedBox(
    //             height: 40,
    //             child: TextField(
    //               controller: msgController,
    //               // maxLines: 50,
    //               style: const TextStyle(fontSize: 17, color: Colors.white),
    //               decoration: InputDecoration(
    //                 enabledBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(10),
    //                   borderSide:
    //                       BorderSide(color: Theme.of(context).primaryColor),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(10),
    //                   borderSide:
    //                       BorderSide(color: Theme.of(context).primaryColor),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           left: 22,
    //           right: 5.0,
    //         ),
    //         child: ActionButtonWidget(
    //           color: const Color.fromRGBO(243, 157, 55, 1),
    //           icon: Icons.send_rounded,
    //           onPressed: () {
    //             widget.onPressed(msgController.value.text);
    //             msgController.clear();
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

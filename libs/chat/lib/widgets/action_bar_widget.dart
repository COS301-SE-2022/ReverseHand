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
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsets.only(left: 30, right: 10),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:  BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:  BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 22,
                right: 5.0,
              ),
              child: ActionButton(
                color: Color.fromRGBO(243, 157, 55, 1),
                icon: Icons.send_rounded,
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

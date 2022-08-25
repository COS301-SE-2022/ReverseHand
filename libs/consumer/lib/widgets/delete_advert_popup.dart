import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

//popup info for deleting an advert

class DeletePopUpWidget extends StatelessWidget {
  final void Function() action;

  const DeletePopUpWidget({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //************TEXT*******************/
        Container(
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Are you sure you want to delete this job?\n\n This action cannot be undone.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        //***********************************/

        const Padding(padding: EdgeInsets.all(8)),

        //************BUTTONS*******************/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Delete
            ButtonWidget(text: "Delete", function: () {}),
            const Padding(padding: EdgeInsets.all(5)),
            //Cancel
            ButtonWidget(
              text: "Cancel",
              function: () {
                action();
                Navigator.pop(context);
              },
              color: "light",
              border: "lightBlue",
            )
          ],
        )
        //**************************************/
      ],
    );
  }
}

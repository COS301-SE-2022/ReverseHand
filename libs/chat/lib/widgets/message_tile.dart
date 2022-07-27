import 'package:flutter/material.dart';

//*****************THE RECEIVING MESSAGE****************/
class MessageTileWidget extends StatelessWidget {
  final String message;
  const MessageTileWidget({
    required this.message,
    Key? key,
    // required this.message,
  }) : super(key: key);

  // final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child:
                    Text(message, style: const TextStyle(color: Colors.black)),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 8, top: 8.0),
                child: Text("12:03"))
          ],
        ),
      ),
    );
  }
}
//*******************************************************/

//*****************THE SENDING MESSAGE******************/
class MessageOwnTileWidget extends StatelessWidget {
  final String message;
  const MessageOwnTileWidget({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child:
                    Text(message, style: const TextStyle(color: Colors.white)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8, top: 8.0),
              child: Text("12:03"),
            )
          ],
        ),
      ),
    );
  }
}
//*******************************************************/

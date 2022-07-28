import 'package:flutter/material.dart';
import 'package:redux_comp/models/chat/message_model.dart';

//*****************THE RECEIVING MESSAGE****************/
class MessageTileWidget extends StatelessWidget {
  final MessageModel message;
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
                child: Text(message.msg,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8, top: 8.0),
                child: Text(
                  getTime(message.timestamp.toInt()),
                ))
          ],
        ),
      ),
    );
  }
}
//*******************************************************/

//*****************THE SENDING MESSAGE******************/
class MessageOwnTileWidget extends StatelessWidget {
  final MessageModel message;
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
                child: Text(message.msg,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 8.0),
              child: Text(
                getTime(message.timestamp.toInt()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//*******************************************************/

String getTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
  String minute = date.minute.toString();
  minute = minute.length == 1 ? "0$minute" : minute;

  return "${date.hour}:$minute";
}

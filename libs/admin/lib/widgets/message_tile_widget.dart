import 'package:flutter/material.dart';
import 'package:redux_comp/models/chat/message_model.dart';

//*****************THE RECEIVING MESSAGE****************/
class MessageTileWidget extends StatelessWidget {
  final MessageModel message;
  const MessageTileWidget({
    required this.message,
    Key? key,
  }) : super(key: key);

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
              decoration: BoxDecoration(
                color: getHue(message.sentiment),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Text(message.msg,
                    style: const TextStyle(color: Colors.black, fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8.0),
              child: Text(
                "Score: ${message.sentiment.toStringAsFixed(2)}",
              ),
            )
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
                color: getHue(message.sentiment),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Text(message.msg,
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 8.0),
              child: Text(
                "Score: ${message.sentiment.toStringAsFixed(2)}",
              ),
            )
          ],
        ),
      ),
    );
  }
}
//*******************************************************/

Color getHue(double sentiment) {

  Color color = HSVColor.lerp(HSVColor.fromColor(Colors.red),
      HSVColor.fromColor(Colors.green), (sentiment + 5) / 10)!.toColor();
  return color;
}

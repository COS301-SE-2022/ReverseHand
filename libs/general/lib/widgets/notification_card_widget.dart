import 'package:flutter/material.dart';

//******************************** */
//  card widget for notifications
//******************************** */

//your bid was accepted
//you lost a bid

//you have a new bid

class NotificationCardWidget extends StatelessWidget {
  final String titleText;
  final String date;

  const NotificationCardWidget({
    Key? key,
    required this.titleText,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                  child: Text(titleText,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(date,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70)),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 12)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          titleText == "Accepted!"
                              ? "Your bid was accepted. A chat has been created between you and your client."
                              : titleText == "New Bid!"
                                  ? "A bid was made on your advert."
                                  : "A job which you bid on has been closed.",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

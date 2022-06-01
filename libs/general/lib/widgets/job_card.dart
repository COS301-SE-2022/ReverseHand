import 'package:flutter/material.dart';

class JobCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String date;
  final String location;
  const JobCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.date,
      required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromRGBO(35, 47, 62, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(titleText,
                    style: const TextStyle(fontSize: 30, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(3)),
                Text(descText,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: [
                    const Text(
                      "Posted     :   ",
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Row(
                  children: [
                    const Text(
                      "Location  :   ",
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

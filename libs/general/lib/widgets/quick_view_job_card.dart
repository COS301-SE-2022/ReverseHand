import 'package:flutter/material.dart';

class QuickViewJobCardWidget extends StatelessWidget {
  final String titleText;
  final String date;
  final String location;
  final void Function() onTap;

  const QuickViewJobCardWidget({
    Key? key,
    required this.titleText,
    required this.date,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
                children: [
                  Text(titleText,
                      style:
                          const TextStyle(fontSize: 30, color: Colors.white)),
                  const Padding(padding: EdgeInsets.all(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      Column(children: [
                        Text(date,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white70)),
                        Text(location,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white))
                      ])
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

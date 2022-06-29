import 'package:flutter/material.dart';

class JobCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String date;
  const JobCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.date})
      : super(key: key);

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //****************TITLE********************//
              Text(titleText,
                  style: const TextStyle(fontSize: 35, color: Colors.white)),
              //*****************************************//

              Row(
                children: [
                  // const Text(
                  //   "Posted: ",
                  //   style: TextStyle(fontSize: 20, color: Colors.white70),
                  // ),
                  //still deciding if this should be here
                  Text(
                    date,
                    style: const TextStyle(fontSize: 20, color: Colors.white70),
                  )
                ],
              ),

              //****************LOCATION********************//
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: const [
              //       Icon(
              //         Icons.location_on,
              //         color: Colors.white,
              //         size: 30.0,
              //       ),
              //       Text("Pretoria, Gauteng",
              //           style: TextStyle(fontSize: 20, color: Colors.white))
              //     ],
              //   ),
              // ),
              //*****************************************//

              //will be added when location is implemented

              const Padding(padding: EdgeInsets.all(10)),

              //****************DESCRIPTION*******************//
              Text(descText,
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              //**********************************************/

              const Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ],
      ),
    );
  }
}

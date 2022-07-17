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
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //****************TITLE********************//
              Text(titleText,
                  style: const TextStyle(fontSize: 35, color: Colors.white)),
              //*****************************************//

              //****************DATE*******************//
              Row(
                children: [
                  // const Text(
                  //   "Posted: ",
                  //   style: TextStyle(fontSize: 20, color: Colors.white70),
                  // ),
                  //still deciding if this should be here
                  Text(
                    date,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
              //****************************************//

              //****************LOCATION********************//
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: const [
                    // Icon(
                    //   Icons.location_on,
                    //   color: Colors.white,
                    //   size: 30.0,
                    // ), //icon spacing is giving issues at the moment
                    Text("Pretoria, Gauteng",
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              //*****************************************//

              //****************DESCRIPTION*******************//
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: Text(descText,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ),
              //**********************************************/
            ],
          ),
        ],
      ),
    );
  }
}

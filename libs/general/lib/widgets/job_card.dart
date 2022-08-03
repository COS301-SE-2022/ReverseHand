import 'package:flutter/material.dart';

class JobCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String location;
  final String type;
  final String date;
  const JobCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.location,
      required this.type,
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                child: Text(titleText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 35, color: Colors.white)),
              ),
              //*****************************************//

              //****************DATE*******************//
              Row(
                children: [
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
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 22,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 2)),
                    Text(location,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              //*****************************************//

              //****************TRADE********************//
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.construction_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 2)),
                    Text(type,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              //*****************************************//

              //****************DESCRIPTION*******************//
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(descText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),

              //**********************************************/
            ],
          ),
        ],
      ),
    );
  }
}

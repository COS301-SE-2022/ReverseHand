import 'package:flutter/material.dart';
import './job_details.dart';
import 'package:flutter/rendering.dart';

class ConsumerJobListings extends StatefulWidget {
  const ConsumerJobListings({Key? key}) : super(key: key);

  @override
  ConsumerJobState createState() => ConsumerJobState();
}

class ConsumerJobState extends State<ConsumerJobListings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Job Listings'),
          backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
        ),
        body: const MyCardWidget(),
      ),
    );
  }
}

// class MyCardWidget extends StatelessWidget {
//   const MyCardWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       height: 200,
//       padding: const EdgeInsets.all(5.0),
//       child: Center(
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           color: const Color.fromRGBO(22, 32, 71, 1),
//           elevation: 5,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: const <Widget>[
//                 ListTile(
//                   title: Text(
//                     'Title',
//                     style: TextStyle(fontSize: 30.0, color: Colors.white),
//                   ),
//                   subtitle: Text('Location - Date',
//                       style: TextStyle(fontSize: 18.0, color: Colors.white)),
//                   dense: false,
//                   contentPadding: ,
//                 ),
//                 // ListTile(
//                 //   title: Text(
//                 //     'Title',
//                 //     style: TextStyle(fontSize: 30.0, color: Colors.white),
//                 //   ),
//                 //   subtitle: Text('Location - Date',
//                 //       style: TextStyle(fontSize: 18.0, color: Colors.white)),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (_) => const ConsumerDetails(,)));
            },
            child: Card(
              color: const Color.fromARGB(255, 86, 159, 92),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                      child: Text(
                        '2 Days ago',
                        style: TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Roof painting',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    subtitle: Text(
                      '22 May 2022 - 28 May 2022',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

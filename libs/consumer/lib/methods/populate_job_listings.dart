import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import '../pages/create_new_job.dart';
import '../pages/job_details.dart';

class JobListings extends StatelessWidget {
  final Store<AppState> store;
  // final List<Advert?> adverts;

  const JobListings({
    Key? key,
    required this.store,
    /* required this.adverts */
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Expanded(
      //   child: ListView(
      //     children: adverts.map((advert) => JobListing(store: store, advert: advert)).toList()
      //   ),
      // ),

      Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
            shadowColor: Colors.black,
            elevation: 9,
            textStyle: const TextStyle(fontSize: 30),
            minimumSize: const Size(60, 60),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => CreateNewJob(store: store)));
          },
          child: const Text("+"), //Look into an icon for demo 3
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      ),
    ]);
  }
}

// class JobListing extends StatelessWidget {
//   final Store<AppState> store;
//   // final Advert? advert;

//   const JobListing({
//     Key? key,
//     required this.store,
//     /*required this.advert*/
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (_) => ConsumerDetails(store: store)));
//       },
//       child: Card(
//         color: const Color.fromRGBO(53, 79, 82, 1),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         elevation: 2,
//         child: Column(
//           children: const [
//             ListTile(
//               title: Text(
//                 "Title: null",
//                 style: TextStyle(fontSize: 25.0, color: Colors.white),
//               ),
//               subtitle: Text(
//                 "Description: null",
//                 style: TextStyle(fontSize: 15.0, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

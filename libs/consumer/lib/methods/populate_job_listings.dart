import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import '../pages/job_details.dart';

class JobListings extends StatelessWidget {

  final Store<AppState> store;
  final List<Advert?> adverts;


  const JobListings({Key? key, required this.store, required this.adverts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: adverts.map((advert) => JobListing(store: store, advert: advert)).toList(),
    );
    // const Padding(
    //       padding:
    //           EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
    //     ),
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Container(
    //         height: 60,
    //         width: 80,
    //         decoration: BoxDecoration(
    //             color: const Color.fromRGBO(132, 169, 140, 1),
    //             borderRadius: BorderRadius.circular(30)),
    //         child: TextButton(
    //           onPressed: () {
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (_) => JobCreation(store: store)));
    //           },
    //           child: const Text(
    //             '+',
    //             style: TextStyle(color: Colors.white, fontSize: 25),
    //           ),
    //         ),
    //       ),
    //     );
  }
}

class JobListing extends StatelessWidget {

  final Store<AppState> store;
  final Advert? advert;

  const JobListing({Key? key, required this.store, required this.advert}) : super(key: key);


 @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ConsumerDetails(store: store)));
      },
      child: Card(
        color: const Color.fromRGBO(53, 79, 82, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              title: Text(
                advert!.title ?? "Title: null",
                // ignore: prefer_const_constructors  
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              subtitle:  Text(
                advert!.description ?? "Description: null",
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              // trailing: Text(
              //   '2 days ago',
              //   style: TextStyle(
              //       color: Colors.white.withOpacity(0.7),
              //       fontSize: 15.0),
              // ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.location_on, size: 50),
            //   title: Text(
            //     '22/05/2022 - 28/05/2022',
            //     style: TextStyle(
            //         color: Colors.white.withOpacity(0.7),
            //         fontSize: 15.0),
            //   ),
            //   subtitle: Text(
            //     'Pretoria, Gauteng',
            //     style: TextStyle(
            //         color: Colors.white.withOpacity(0.7),
            //         fontSize: 20.0),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}








import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import './job_details.dart';
import 'package:redux_comp/redux_comp.dart';
import './create_new_job.dart';

class ConsumerListings extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My Job Listings'),
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
          ),
          body: 
          StoreConnector<AppState, List<Advert>> (
            converter: (store) => store.state.adverts,
            builder: (context, adverts) {
              return ListView(
                children: []//function(adverts) return list of job listings,
              );
            },
          )
          // ListView(
          
            // children: [
            //   InkWell(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (_) => ConsumerDetails(store: store)));
            //     },
            //     child: Card(
            //       color: const Color.fromRGBO(53, 79, 82, 1),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15.0),
            //       ),
            //       elevation: 2,
            //       child: Column(
            //         children: [
            //           ListTile(
            //             title: const Text(
            //               'Roof painting',
            //               style: TextStyle(fontSize: 25.0, color: Colors.white),
            //             ),
            //             trailing: Text(
            //               '2 days ago',
            //               style: TextStyle(
            //                   color: Colors.white.withOpacity(0.7),
            //                   fontSize: 15.0),
            //             ),
            //           ),
            //           ListTile(
            //             leading: const Icon(Icons.location_on, size: 50),
            //             title: Text(
            //               '22/05/2022 - 28/05/2022',
            //               style: TextStyle(
            //                   color: Colors.white.withOpacity(0.7),
            //                   fontSize: 15.0),
            //             ),
            //             subtitle: Text(
            //               'Pretoria, Gauteng',
            //               style: TextStyle(
            //                   color: Colors.white.withOpacity(0.7),
            //                   fontSize: 20.0),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   const Padding(
            //     padding:
            //         EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            //   ),
            //   Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       height: 60,
            //       width: 80,
            //       decoration: BoxDecoration(
            //           color: const Color.fromRGBO(132, 169, 140, 1),
            //           borderRadius: BorderRadius.circular(30)),
            //       child: TextButton(
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (_) => JobCreation(store: store)));
            //         },
            //         child: const Text(
            //           '+',
            //           style: TextStyle(color: Colors.white, fontSize: 25),
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
          // ),
        ),
      ),
    );
  }
}
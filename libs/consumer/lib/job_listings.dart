import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './job_details.dart';
import 'package:redux/redux.dart';
import 'package:redux_comp/redux_comp.dart';
// import 'package:flutter/rendering.dart';
//import 'package:flutter/rendering.dart';

class ConsumerListings extends StatelessWidget {
  ///const Login({Key? key}) : super(key: key);
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
          body: ListView(
            children: [
              InkWell(
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
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                      //     child: Text(
                      //       '2 Days ago',
                      //       style:
                      //           TextStyle(color: Colors.white.withOpacity(0.6)),
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        title: const Text(
                          'Roof painting',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                        trailing: Text(
                          '2 days ago',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15.0),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on, size: 50),
                        title: Text(
                          '22/05/2022 - 28/05/2022',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15.0),
                        ),
                        subtitle: Text(
                          'Pretoria, Gauteng',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

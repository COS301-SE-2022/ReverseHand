import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:redux_comp/redux_comp.dart';
import './job_listings.dart';

// import 'package:amplify/models/Advert.dart';
// import 'package:redux_comp/actions/create_advert_action.dart';
//these imports might be necessary when backend is linked - will be removed after linking

class JobCreation extends StatefulWidget {
  final Store<AppState> store;
  const JobCreation({Key? key, required this.store}) : super(key: key);

  @override
  State<JobCreation> createState() => _JobCreationState();
}

class _JobCreationState extends State<JobCreation> {
  final titleController = TextEditingController();
  final descrController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descrController.dispose();
    locationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
            // body: Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         children: [
            //           const Padding(
            //             padding: EdgeInsets.only(top: 15.0),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 15.0, right: 15.0, top: 15, bottom: 15),
            //             child: TextField(
            //               decoration: const InputDecoration(
            //                   border: OutlineInputBorder(), labelText: 'Title'),
            //               controller: titleController,
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 15.0, right: 15.0, top: 15, bottom: 15),
            //             child: TextField(
            //               controller: descrController,
            //               decoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Description'),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 15.0, right: 15.0, top: 15, bottom: 15),
            //             child: TextField(
            //               controller: locationController,
            //               decoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Location'),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 15.0, right: 15.0, top: 15, bottom: 15),
            //             child: TextField(
            //               controller: dateController,
            //               decoration: const InputDecoration(
            //                   border: OutlineInputBorder(), labelText: 'Date'),
            //             ),
            //           ),
            //           Container(
            //             height: 60,
            //             width: 250,
            //             decoration: BoxDecoration(
            //                 color: const Color.fromRGBO(132, 169, 140, 1),
            //                 borderRadius: BorderRadius.circular(20)),
            //             child: StoreConnector<AppState, VoidCallback>(
            //               converter: (store) {
            //                 return () => store.dispatch(CreateAdvertAction(Advert(
            //                     customer: store.state.user!.getId(),
            //                     title: titleController.value.text,
            //                     description: descrController.value.text)));
            //               },
            //               builder: (context, callback) {
            //                 return TextButton(
            //                   onPressed: () {
            //                     callback();
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (_) => ConsumerListings(
            //                                 store: widget.store)));
            //                   },
            //                   child: const Text(
            //                     'Add New Job',
            //                     style:
            //                         TextStyle(color: Colors.white, fontSize: 20),
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            //COMMENTS ARE KEPT TO INTEGRATE WITH BACKEND LATER!
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: TextFieldWidget(label: "Title", obscure: false),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child:
                        TextFieldWidget(label: "Description", obscure: false),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: TextFieldWidget(label: "Location", obscure: false),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ConsumerListings(store: widget.store)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 9,
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(180, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      child: const Text("Add new job")),
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/create_advert_action.dart';
import 'package:redux_comp/redux_comp.dart';
import '../consumer.dart';

class JobCreation extends StatefulWidget {
  final Store<AppState> store;
  const JobCreation({Key? key, required this.store}) : super(key: key);

  @override
  State<JobCreation> createState() => _JobCreationState();
}

class _JobCreationState extends State<JobCreation> {
  final titleController = TextEditingController();
  final descrController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //**********PADDING FOR TOP**********************//
                  const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                  //***********************************//

                  //**********BACKBUTTON**************************//
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConsumerListings(store: widget.store),
                        ),
                      );
                    },
                  ),
                  //************************************************//

                  //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                    child: TextFieldWidget(
                      label: "Title",
                      obscure: false,
                      controller: titleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: TextFieldWidget(
                      label: "Description",
                      obscure: false,
                      controller: descrController,
                    ),
                  ),
                  //*************************************************//

                  //**********CREATE NEW JOB BUTTON*****************//
                  StoreConnector<AppState, VoidCallback>(converter: (store) {
                    return () => store.dispatch(
                          CreateAdvertAction(
                            "c#001",
                            titleController.value.text.trim(),
                            description: descrController.value.text.trim(),
                          ),
                        );
                  }, builder: (context, callback) {
                    return (ElevatedButton(
                        onPressed: () {
                          callback();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ConsumerListings(store: widget.store),
                            ),
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
                        child: const Text("Add new job")));
                  })
                  //*************************************************
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/textfield.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ConsumerListings(store: widget.store)));
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
            ),
          ),
        ));
  }
}

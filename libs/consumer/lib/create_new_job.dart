import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/create_advert_action.dart';
import 'package:redux_comp/redux_comp.dart';
import './job_listings.dart';

class JobCreation extends StatelessWidget {
  final Store<AppState> store;
  const JobCreation({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: const Text('Creating a job'),
          backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ConsumerListings(store: store)));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Title'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Description'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Location'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Date'),
                ),
              ),
              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(132, 169, 140, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: StoreConnector<AppState, VoidCallback>(
                  converter:(store) {
                    return () =>  store.dispatch(CreateAdvertAction(Advert(consumerID: store.state.id, title: "Test", description: "Test")));
                  },
                  builder: (context, callback) {
                    return TextButton(
                      onPressed: () {
                        callback();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ConsumerListings(store: store)));
                      },
                      child: const Text(
                        'Add New Job',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_comp/redux_comp.dart';
import './job_listings.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
     store: store,
     child: 
     MaterialApp(
        home: Scaffold(
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TradesmanJobListings(store: store)));
              },
            ),
            title: const Text('ROOF PAINTING'),
          ),
          body: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [ 
                        Card(
                          color: const Color.fromRGBO(53, 79, 82, 1),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 2,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text(
                                "Description",
                                style: TextStyle(fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                "Painting of inside roof's of Main Bedroom, Guest Room, Lounge Room and Kitchen and Dining. We believe that 6 days is sufficient to get it all done.Hoping for someone hard-working with good rates.",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Card(
                        color: const Color.fromRGBO(132, 169, 140, 1),
                        elevation: 2,
                        child: Column(
                          children: const [
                            ListTile(
                              title: Text(
                                'Info',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                              subtitle: Text(
                                ' Customer Name: Tony Stark\n Cellphone: +27 987 2356\n Email: stark@industries.com',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {},
                        child: const Text('Bid'),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
     ),
    );
  }
}
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class LocationResultWidget extends StatelessWidget {
  final Store<AppState> store;
  const LocationResultWidget({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (store.state.partialUser!.place == null) {
      return const Text("Please search your address!");
    } else {
      return Column(
        children: [
          //Street Number
          Row(
            children: const [
              Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 26.0,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("Street Number",
                  style: TextStyle(fontSize: 26, color: Colors.white70)),
            ],
          ),

          Text(
            store.state.partialUser!.place!.streetNumber!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),

          //Street Name

          Row(
            children: const [
              Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 26.0,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("Street Name",
                  style: TextStyle(fontSize: 26, color: Colors.white70)),
            ],
          ),

          Text(
            store.state.partialUser!.place!.street!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),

          //City
          Row(
            children: const [
              Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 26.0,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("City",
                  style: TextStyle(fontSize: 26, color: Colors.white70)),
            ],
          ),

          Text(
            store.state.partialUser!.place!.city!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),

          //Province
          Row(
            children: const [
              Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 26.0,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("Province",
                  style: TextStyle(fontSize: 26, color: Colors.white70)),
            ],
          ),

          Text(
            store.state.partialUser!.place!.province!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),

          //Postal Code/zipCode
          Row(
            children: const [
              Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 26.0,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("Postal Code",
                  style: TextStyle(fontSize: 26, color: Colors.white70)),
            ],
          ),
          Text(
            store.state.partialUser!.place!.zipCode!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
    }
  }
}

import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

import '../adverts/view_adverts_action.dart';
import '../adverts/view_jobs_action.dart';

/* GetUserAction */
/* This action fetches a user of a specified group and populates the user model with the results */

class GetUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // request different info for different user type
    if (state.userDetails!.userType != "Tradesman") {
      final String id = state.userDetails!.id;
      String graphQLDoc = '''query  {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          location {
            address {
              streetNumber
              street
              city
              zipCode
            }
            coordinates {
              lat
              lng
            }
          }
        }
      }
      ''';

      final request = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        await Amplify.API.mutate(request: request).response;
        final data = jsonDecode(
            (await Amplify.API.mutate(request: request).response).data);
        final user = data["viewUser"];
        // build place model from result
        String streetNumber = user["location"]["address"]["streetNumber"];
        String street = user["location"]["address"]["street"];
        String city = user["location"]["address"]["city"];
        String zipCode = user["location"]["address"]["zipCode"];
        double lat = double.parse(user["location"]["coordinates"]["lat"]);
        double long = double.parse(user["location"]["coordinates"]["lng"]);
        Address address = Address(
            streetNumber: streetNumber,
            street: street,
            city: city,
            province: "",
            zipCode: zipCode);
        Coordinates coords = Coordinates(lat: lat, long: long);

        return state.copy(
          userDetails: state.userDetails!.copy(
            name: user["name"],
            cellNo: user["cellNo"],
            email: user["email"],
            location: Location(address: address, coordinates: coords),
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      final String id = state.userDetails!.id;
      String graphQLDoc = '''query {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          domains
          tradetypes
          location {
            address {
              streetNumber
              street
              city
              zipCode
            }
            coordinates {
              lat
              lng
            }
          }
        }
      }
      ''';

      final request = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final data = jsonDecode(
            (await Amplify.API.mutate(request: request).response).data);
        final user = data["viewUser"];

        String streetNumber = user["location"]["address"]["streetNumber"];
        String street = user["location"]["address"]["street"];
        String city = user["location"]["address"]["city"];
        String zipCode = user["location"]["address"]["zipCode"];
        double lat = double.parse(user["location"]["coordinates"]["lat"]);
        double long = double.parse(user["location"]["coordinates"]["lng"]);
        Address address = Address(
            streetNumber: streetNumber,
            street: street,
            city: city,
            province: "",
            zipCode: zipCode);
        Coordinates coords = Coordinates(lat: lat, long: long);

        return state.copy(
          userDetails: state.userDetails!.copy(
            name: user["name"],
            email: user["email"],
            cellNo: user["cellNo"],
            domains: user["domains"],
            tradeTypes: user["tradetypes"],
            location: Location(address: address, coordinates: coords),
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    }
  }

  @override
  void after() async {
    state.userDetails!.userType == "Consumer"
        ? await dispatch(ViewAdvertsAction(state.userDetails!.id))
        : await dispatch(ViewJobsAction());
    dispatch(NavigateAction.pushNamed(
        "/${state.userDetails!.userType.toLowerCase()}"));
  }
}

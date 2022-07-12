import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.user!.userType != "Tradesman") {
      final String id = state.user!.id;
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
              long
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
            (await Amplify.API.mutate(request: request).response)
                .data);
        final user = data["viewUser"];

        Place p = Place();
        Coordinates c = Coordinates();
        p.streetNumber = user["location"]["address"]["streetNumber"];
        p.street = user["location"]["address"]["street"];
        p.city = user["location"]["address"]["city"];
        p.city = user["location"]["address"]["zipCode"];
        c.lat = user["location"]["coordinates"]["lat"];
        c.long = user["location"]["coordinates"]["long"];
        p.location = c;

        return state.replace(
          user: state.user!.replace(
            name: user["name"],
            cellNo: user["cellNo"],
            email: user["email"],
            place: p,
            bids: const [],
            shortlistBids: const [],
            viewBids: const [],
            adverts: const [],
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      final String id = state.user!.id;
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
              long
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
            (await Amplify.API.mutate(request: request).response)
                .data);
        final user = data["viewUser"];

        Place p = Place();
        Coordinates c = Coordinates();
        p.streetNumber = user["location"]["address"]["streetNumber"];
        p.street = user["location"]["address"]["street"];
        p.city = user["location"]["address"]["city"];
        p.city = user["location"]["address"]["zipCode"];
        c.lat = user["location"]["coordinates"]["lat"];
        c.long = user["location"]["coordinates"]["long"];
        p.location = c;

        return state.replace(
          user: state.user!.replace(
            name: user["name"],
            email: user["email"],
            cellNo: user["cellNo"],
            domains: user["domains"],
            tradeTypes: user["tradeTypes"],
            place: p,
            bids: const [],
            shortlistBids: const [],
            viewBids: const [],
            adverts: const [],
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    }
  }
}
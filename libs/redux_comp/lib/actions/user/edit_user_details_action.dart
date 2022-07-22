import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class EditUserDetailsAction extends ReduxAction<AppState> {
  final String name;
  final String cellNo;
  final List<String> domains; //for domains
  final String city;
  final String street;
  final String streetNumber;
  final String zipCode;
  final String lat;
  final String lng;
  final String userId;

  EditUserDetailsAction(
      this.name,
      this.cellNo,
      this.domains,
      this.city,
      this.street,
      this.streetNumber,
      this.zipCode,
      this.lat,
      this.lng,
      this.userId);

  @override
  Future<AppState?> reduce() async {
    final d = jsonEncode(domains);

    String graphQLDocument = '''mutation {
      editUserDetail(
        user_id: "$userId", 
        name: "$name", 
        cellNo: "$cellNo",
        domains: "$d",
        city:"$city",
        street: "$street",
        streetNumber:"$streetNumber",
        zipCode: "$zipCode",
        lat: "$lat", 
        lng: "$lng" ){
          cellNo
          name
          location {
            coordinates {
              lat
              lng
            }
            address {
              city
              street
              streetNumber
              zipCode
            }
          }
          domains
          email
      }
    } ''';
    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final data = jsonDecode(
          (await Amplify.API.mutate(request: request).response).data);

      UserModel user = UserModel(
          id: state.userDetails!.id,
          userType: state.userDetails!.userType,
          registered: state.userDetails!.registered,
          tradeTypes: state.userDetails!.tradeTypes,
          cellNo: data["cellNo"],
          name: data["name"],
          location: data["location"],
          domains: data["domains"],
          email: data["email"]);
      return state.copy(userDetails: user);
    } catch (error) {
      return null;
    }
  }
}

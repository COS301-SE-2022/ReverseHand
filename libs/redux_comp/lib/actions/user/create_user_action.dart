import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

/* CreateUserAction */
/* This action creates a user of a specified group if they have been verified on signup */

class CreateUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.partialUser!.verified == "DONE") {
      //pass user information into variables
      final String email =  state.partialUser!.email;
      final String name = state.userDetails!.name!;
      final String cellNo = state.userDetails!.cellNo!;
      final String id = state.userDetails!.id;
      final double lat = state.userDetails!.location!.coordinates.lat;
      final double long = state.userDetails!.location!.coordinates.long;
      final String streetnumber = state.userDetails!.location!.address.streetNumber;
      final String street = state.userDetails!.location!.address.street;
      final String city = state.userDetails!.location!.address.city;
      final String zipCode = state.userDetails!.location!.address.zipCode;

      // different queries for different users
      // If tradesman, DO store domains and tradetypes
      if (state.partialUser!.group == "tradesman") {
        final tradeTypes = jsonEncode(state.userDetails!.tradeTypes!);
        final domains = jsonEncode([city]);
        String graphQLDoc = '''mutation  {
          createUser(
            cellNo: "$cellNo", 
            city: "$city", 
            email: "$email", 
            lat: "$lat", 
            long: "$long", 
            name: "$name", 
            streetNumber: "$streetnumber", 
            user_id: "$id", 
            zipCode: "$zipCode", 
            domains: $domains, 
            street: "$street", 
            tradetypes: $tradeTypes
          ) {
            id
          }
        }
        ''';

        debugPrint(graphQLDoc);
        final requestCreateUser = GraphQLRequest(
          document: graphQLDoc,
        );

        try {
          await Amplify.API.mutate(request: requestCreateUser).response;
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
      } else {
        String graphQLDoc = '''mutation  {
          createUser(
            cellNo: "$cellNo", 
            city: "$city", 
            email: "$email", 
            lat: "$lat", 
            long: "$long", 
            name: "$name", 
            streetNumber: "$streetnumber", 
            user_id: "$id", 
            zipCode: "$zipCode", 
            street: "$street"
          ) {
            id
          }
        }
        ''';

        final requestCreateUser = GraphQLRequest(
          document: graphQLDoc,
        );

        try {
          final resp = await Amplify.API.mutate(request: requestCreateUser).response;
          debugPrint(resp.data);
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
      }
    } else {
      return state.replace(error: ErrorType.failedToCreateUser);
    }
  }

}

import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

/* CreateUserAction */
/* This action creates a user of a specified group if they have been verified on signup */

class CreateUserAction extends ReduxAction<AppState> {
  final String name;
  final String cellNo;
  final Location? location;
  final List<Domain>? domains;
  final List<Domain>? tradeTypes;

  CreateUserAction({required this.name, required this.cellNo, this.location, this.domains, this.tradeTypes });

  @override
  Future<AppState?> reduce() async {
    if (true) {
      //pass user information into variables
      const String id = "t#test";
      const String email = "test@tester.com";
      const String name = "Tester";
      const String cellNo = "0123456789";

      // different queries for different users
      // If tradesman, DO store domains and tradetypes
      if (state.partialUser!.group != "tradesman") {
        // Location locationObj = const Location(
        //   address: Address(
        //       street: "123",
        //       streetNumber: "Test",
        //       city: "TestTown",
        //       province: "TestCounty",
        //       zipCode: "0000"),
        //   coordinates: Coordinates(lat: 22, lng: -12),
        // );

        // String location = locationObj.toString();
        List<Domain> domainObjs = [];
        Domain d1 = const Domain(
            city: "Pretoria", coordinates: Coordinates(lat: 1, lng: 2));
        Domain d2 = const Domain(
            city: "Joburg", coordinates: Coordinates(lat: 1, lng: 2));
        domainObjs.add(d1);
        domainObjs.add(d2);

        var domains = [];

        for (var domain in domainObjs) {
          domains.add(domain.toString());
        }

        debugPrint(domains[0]);

        String graphQLDoc = '''mutation  {
          createUser(
            user_id: "$id", 
            email: "$email", 
            name: "$name", 
            cellNo: "$cellNo", 
            domains: $domains,
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
          final resp =
              await Amplify.API.mutate(request: requestCreateUser).response;
          debugPrint(resp.data);
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
      } else {
        // String graphQLDoc = '''mutation  {
        //   createUser(
        //     cellNo: "$cellNo",
        //     city: "$city",
        //     email: "$email",
        //     lat: "$lat",
        //     long: "$long",
        //     name: "$name",
        //     streetNumber: "$streetnumber",
        //     user_id: "$id",
        //     zipCode: "$zipCode",
        //     street: "$street"
        //   ) {
        //     id
        //   }
        // }
        // ''';

        // final requestCreateUser = GraphQLRequest(
        //   document: graphQLDoc,
        // );

        // try {
        //   final resp =
        //       await Amplify.API.mutate(request: requestCreateUser).response;
        //   debugPrint(resp.data);
        //   return null;
        // } on ApiException catch (e) {
        //   debugPrint(e.message);
        //   return null;
        // }
        return null;
      }
    } else {
      return state.copy(error: ErrorType.failedToCreateUser);
    }
  }
}

// mutation  {
//           createUser(
//             user_id: "t#test",
//             email: "test@tester.com",
//             name: "Tester",
//             cellNo: "0123456789",
//             domains: [{
//       city : Pretoria,
//       coordinates : {
//         lat: 1.0,
//         lng: 2.0,
//       }
//     }, {
//       city : Joburg,
//       coordinates : {
//         lat: 1.0,
//         lng: 2.0,
//       }
//     }],
//           ) {
//             id
//           }
//         }
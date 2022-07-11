import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

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

      final requestCreateUser = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final data = jsonDecode(
            (await Amplify.API.mutate(request: requestCreateUser).response)
                .data);
        final user = data['viewUser'];

        debugPrint(user.toString());
        return state.replace(
          user: state.user!.replace(
            name: user["name"],
            cellNo: user["cellNo"],
            email: user["email"],
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
    } else {}
  }
}

// {
//   "email":"socey92288@leupus.com",
//   "id":"c#97aa91db-ed9e-483a-8326-d8c6ebe4931b",
//   "cellNo":"082309",
//   "location":{
//     "address":{
//       "streetNumber":"318",
//       "street":"The Rand",
//       "city":"Pretoria",
//       "zipCode":"0102"
//       },
//     "coordinates":{
//       "lat":"22.23",
//       "long":"25.34"
//       }
//     },
//   "name":"Rich"
// }
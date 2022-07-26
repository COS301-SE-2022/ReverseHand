import 'package:flutter/material.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class EditUserDetailsAction extends ReduxAction<AppState> {
  final String userId;
  final String? name;
  final String? cellNo;
  final List<Domain>? domains; //for domains
  final Location? location;

  EditUserDetailsAction({
    required this.userId,
    this.name,
    this.cellNo,
    this.domains,
    this.location,
  });

  @override
  Future<AppState?> reduce() async {
    bool isNameChanged = false,
        isCellChanged = false,
        isDomainsChanged = false,
        isLocationChanged = false;

    List<String> domainsQuery = [];



    if (name != null) {
      isNameChanged = true;
    }
    if (cellNo != null) {
      isCellChanged = true;
    }
    if (location != null) {
      isLocationChanged = true;
    }
    if (domains != null) {
      isDomainsChanged = true;

      for (var domain in domains!) {
        domainsQuery.add(domain.toString());
      }
    }

    String graphQLDoc = '''mutation  {
          editUserDetail(
            user_id: "$userId", 
            ${(isNameChanged && (isLocationChanged || isDomainsChanged || isCellChanged)) ? 'name: "$name",' : (isNameChanged && (!isLocationChanged || !isDomainsChanged || isCellChanged)) ? 'name: "$name"' : "" }
            ${(isNameChanged && (isLocationChanged || isDomainsChanged)) ? 'cellNo: "$cellNo",' : (isCellChanged && (!isLocationChanged || !isDomainsChanged)) ? 'cellNo: "$cellNo"' : "" }
            ${(isLocationChanged) ? "location: ${location.toString()}" : ""}
            ${(isDomainsChanged) ? "domains: $domainsQuery" : ""}
          ) {
            id
          }
        }
        ''';

    debugPrint(graphQLDoc);
  }
}

//  mutation  {
//            editUser(
//              user_id: "c#010",
//              name: "Richard"
// 
// 
//            ) {
//              id
//            }
//          }
// 
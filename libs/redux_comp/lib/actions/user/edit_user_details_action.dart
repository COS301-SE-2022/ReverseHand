import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
            ${(isNameChanged && (isLocationChanged || isDomainsChanged || isCellChanged)) 
              ? 'name: "$name",' 
              : (isNameChanged && (!isLocationChanged || !isDomainsChanged || !isCellChanged)) 
              ? 'name: "$name"' 
              : ""}
            ${(isCellChanged && (isLocationChanged || isDomainsChanged)) 
            ? 'cellNo: "$cellNo",' 
            : (isCellChanged && (!isLocationChanged || !isDomainsChanged)) 
            ? 'cellNo: "$cellNo"' 
            : ""}
            ${(isLocationChanged) 
            ? "location: ${location.toString()}" 
            : ""}
            ${(isDomainsChanged) 
            ? "domains: $domainsQuery" 
            : ""}
          ) {
            id
          }
        }
        ''';

    debugPrint(graphQLDoc);

    final requestEditUser = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      final resp = await Amplify.API.mutate(request: requestEditUser).response;
      debugPrint(resp.data);
      return state.copy(
          userDetails: state.userDetails!.copy(
              name: (name != null) ? name : state.userDetails!.name,
              cellNo: (cellNo != null) ? cellNo : state.userDetails!.cellNo,
              location:
                  (location != null) ? location : state.userDetails!.location,
              domains: (domains != null) ? domains : state.userDetails!.domains,
              registered: true));
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToEditUser);
    }
  }

  @override
  void after() {
    if (state.userDetails!.registered == true) {
      dispatch(NavigateAction.pop());
    }
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
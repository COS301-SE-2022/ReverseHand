import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/adverts/view_jobs_action.dart';
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
  final List<String>? tradeTypes;
  final Location? location;

  EditUserDetailsAction({
    required this.userId,
    this.name,
    this.cellNo,
    this.domains,
    this.tradeTypes,
    this.location,
  });

  @override
  Future<AppState?> reduce() async {
    bool isNameChanged = false,
        isCellChanged = false,
        isDomainsChanged = false,
        isTradeChanged = false,
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

      for (Domain domain in domains!) {
        domainsQuery.add(domain.toString());
      }
    }
    if (tradeTypes != null && tradeTypes!.isNotEmpty) {
      isTradeChanged = true;
    }

    String graphQLDoc = '''mutation  {
          editUserDetail(
            user_id: "$userId", 
            ${(isNameChanged && (isLocationChanged || isDomainsChanged)) ? 'name: "$name",' : (isNameChanged && (!isLocationChanged || !isDomainsChanged)) ? 'name: "$name"' : ""}
            ${(isCellChanged && (isLocationChanged || isDomainsChanged)) ? 'cellNo: "$cellNo",' : (isCellChanged && (!isLocationChanged || !isDomainsChanged)) ? 'cellNo: "$cellNo"' : ""}
            ${(isTradeChanged) ? "domains: $domainsQuery," : (!isTradeChanged) ? "domains: $domainsQuery" : ""}
            ${(isTradeChanged) ? "tradetypes: ${jsonEncode(tradeTypes)}" : ""}
            ${(isLocationChanged) ? "location: ${location.toString()}" : ""}
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
              tradeTypes: (tradeTypes != null || tradeTypes!.isNotEmpty)
                  ? tradeTypes
                  : state.userDetails!.tradeTypes,
              registered: true));
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToEditUser);
    }
  }

  @override
  void after() {
    dispatch(NavigateAction.pop());
    if (state.userDetails!.userType == "Tradesman") {
      List<String> domains = [];
      for (Domain d in state.userDetails!.domains) {
        domains.add(d.city);
      }
      List<String> tradeTypes = state.userDetails!.tradeTypes;
      dispatch(ViewJobsAction(domains, tradeTypes));
    }
  }
}

// mutation  {
//  editUserDetail(
//  user_id: "t#0bffe7a9-b767-4578-b60a-270b94d4a9d8",
//  domains: [{
//  city : "Umhlanga",
//  coordinates : {
//  lat: -29.7183126,
//  lng: 31.0708514,
//  }
//  }],
//  tradetypes: ["Painting","Plumbing"]
//  ) {
//  id
//  }
//  }
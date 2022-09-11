import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetReportedCustomersAction extends ReduxAction<AppState> {
  String city;

  GetReportedCustomersAction({required this.city});

  @override
  Future<AppState?> reduce() async {
    String province = state.userDetails!.scope!;
    String graphQLDoc = '''query {
      getReportedCustomers(scope: "$province", city: "$city") {
        id
        email
        name
        cellNo
      }
    }''';

    final request = GraphQLRequest(document: graphQLDoc);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<ReportedUserModel> customers = [];
      dynamic data = jsonDecode(response.data)['getReportedCustomers'];
      for (var user in data) {
        customers.add(ReportedUserModel.fromJson(user));
      }
      return state.copy(
        admin: state.admin.copy(reportedCustomers: customers),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}

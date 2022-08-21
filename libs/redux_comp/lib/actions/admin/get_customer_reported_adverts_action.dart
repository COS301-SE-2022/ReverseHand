import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetCustomerReportedAdvertsAction extends ReduxAction<AppState> {
  String customerId;
  GetCustomerReportedAdvertsAction(this.customerId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = ''' query {
     getCustomerReportedAdverts(customer_id: "c#001") {
      id
      count
      advert {
        title
        id
        description
        date_created
        type
        domain {
          city
          coordinates {
            lat
            lng
          }
        }
        accepted_bid
        date_closed
      }
      reports {
        description
        reason
        tradesman_id
      }
    }
  }''';

    final request = GraphQLRequest(document: graphQLDoc);

    try {
      final response = await Amplify.API.query(request: request).response;
      final List<ReportedAdvertModel> adverts = [];
      
      dynamic data = jsonDecode(response.data)['getCustomerReportedAdverts'];
      for (dynamic ad in data) {
        adverts.add(ReportedAdvertModel.fromJson(ad));
      }
      return state.copy(
        admin: state.admin.copy(activeAdverts: adverts),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void after() {
    dispatch(NavigateAction.pushNamed('/admin_consumer_advert_reports'));
  }
}

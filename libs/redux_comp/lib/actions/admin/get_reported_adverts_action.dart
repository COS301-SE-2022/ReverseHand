import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetReportedAdvertsAction extends ReduxAction<AppState> {
  String province;
  GetReportedAdvertsAction(this.province);

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = ''' query {
      getReportedAdverts(province: "Gauteng") {
        id
        reports {
          description
          reason
          tradesman_id
        }
        customer_id
        count
        advert {
          accepted_bid
          date_created
          description
          domain {
            city
            province
            coordinates {
              lat 
              lng
            }
          }
        id
        title
        type
      }
    }
  }''';

    final request = GraphQLRequest(document: graphQLDoc);

    try {
      final response = await Amplify.API.query(request: request).response;
      final List<ReportedAdvertModel> adverts = [];

      dynamic data = jsonDecode(response.data)['getReportedAdverts'];
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
  void before() {
    dispatch(WaitAction.add("ReportedAdverts"));
  }

  @override
  void after() {
    dispatch(WaitAction.remove("ReportedAdverts"));
  }
}

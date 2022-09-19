import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetReportedAdvertsAction extends ReduxAction<AppState> {
  final String? scope;

  GetReportedAdvertsAction({this.scope});

  @override
  Future<AppState?> reduce() async {

    String province = scope ?? state.userDetails.scope!; 
    String graphQLDoc = '''query {
      getReportedAdverts(province: "$province") {
        count
        reports {
          description
          reason
          reporter_user {
            id
            name
          }
        }
        advert {
          domain {
            city
            province
            coordinates {
              lat
              lng
            }
          }
          id
          customer_id
          title
          type
          description
          date_created
        }
      }
    }
    ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["getReportedAdverts"];

      List<ReportedAdvertModel> reports = [];
      for (dynamic d in data) {
        reports.add(ReportedAdvertModel.fromJson(d));
      }

      return state.copy(
        admin: state.admin.copy(
          adminManage: state.admin.adminManage.copy(advertReports: reports),
        ),
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
    dispatch(WaitAction.add("advert_reports"));
  }

  @override
  void after() => dispatch(WaitAction.remove("advert_reports"));
}
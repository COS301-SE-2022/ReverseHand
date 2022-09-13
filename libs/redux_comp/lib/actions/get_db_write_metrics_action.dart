import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../models/error_type_model.dart';

class GetDbWriteMetricsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getDBWriteDashboard 
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;
      final data = jsonDecode(response.data)["getDBWriteDashboard"];


      //response is a list of reviews so just replace all the
      //current reviews with updated list from lambda
      return state.copy(
        admin: state.admin.copy(
          dash: Image.memory(base64.decode(data)),
        ),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToAddReview);
    }
  }
}

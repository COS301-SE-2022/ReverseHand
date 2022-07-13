import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';
import '../../models/advert_model.dart';

class ViewJobsAction extends ReduxAction<AppState> {
	@override
	Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewJobs(locations: "Pretoria", type: "Plumbing") {
        date_created
        date_closed
        description
        location
        title
        type
        accepted_bid
        id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<AdvertModel> adverts = [];
      dynamic data = jsonDecode(response.data)['viewJobs'];
      data.forEach((el) => adverts.add(AdvertModel.fromJson(el)));

      return state.replace(
        user: state.user!.replace(
          adverts: adverts,
        ),
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

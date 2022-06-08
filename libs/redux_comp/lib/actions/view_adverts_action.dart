import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../models/advert_model.dart';

class ViewAdvertsAction extends ReduxAction<AppState> {
  final String consId; // consumer id whos adverts you wish to retrieve

  ViewAdvertsAction(this.consId);

  @override
  Future<AppState?> reduce() async {
    await store.waitCondition((state) => state.loading == false);

    String graphQLDocument = '''query {
      viewAdverts(user_id: "$consId") {
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
      dynamic data = jsonDecode(response.data)['viewAdverts'];
      data.forEach((el) => adverts.add(AdvertModel.fromJson(el)));

      return state.replace(user: state.user!.replace(adverts: adverts));
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

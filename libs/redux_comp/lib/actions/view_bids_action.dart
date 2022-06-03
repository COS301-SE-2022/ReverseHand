import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ViewBidsAction extends ReduxAction<AppState> {
  final String adId;

  ViewBidsAction(this.adId);

  @override
  Future<AppState?> reduce() async {
    const viewBids = 'viewBids';
    String graphQLDocument = '''
      query ViewBids(\$ad_id: String!) {
        $viewBids(ad_id: "a#001") {
          id
          adver_id
          user_id
          price_lower
          price_upper
          quote
          date_created
          date_closed
        }
      }
    ''';

    final request = GraphQLRequest(
      document: graphQLDocument,
      variables: <String, String>{'ad_id': adId},
      decodePath: viewBids,
    );

    final response = await Amplify.API.query(request: request).response;
    print(response.data);
    print(jsonDecode(response.data));

    return state;
  }
}

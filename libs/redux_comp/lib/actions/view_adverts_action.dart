import 'package:amplify_api/amplify_api.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../models/advert_model.dart';

class ViewAdvertsAction extends ReduxAction<AppState> {
  final String cons_id; // consumer id whos adverts you wish to retrieve

  ViewAdvertsAction(this.cons_id);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewBids(ad_id: "$cons_id") {
        id
        user_id
        description
        type
        bids
        shortlisted_bids
        accepted_bid
        location
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<AdvertModel> adverts = [];
      response.data['viewAdverts']
          .forEach((el) => adverts.add(AdvertModel.fromJson(el)));

      return state.replace(user: state.user!.replace(adverts: adverts));
    } catch (e) {
      return state;
    }
  }
}

import 'dart:convert';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/advert_model.dart';

class GetBidOnAdvertsAction extends ReduxAction<AppState> {
  final String? tradesmanId;

  GetBidOnAdvertsAction({this.tradesmanId});

  @override
  Future<AppState?> reduce() async {
    final String userId = tradesmanId ?? state.userDetails.id;

    String graphQLDocument = '''query {
      getBidOnAdverts(tradesman_id: "$userId") {
        date_created
        date_closed
        description
        domain {
          city
          province
          coordinates {
            lat
            lng
          }
        }
        title
        type
        accepted_bid
        id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<dynamic> data = jsonDecode(response.data)['getBidOnAdverts'];
      List<AdvertModel> adverts =
          data.map((e) => AdvertModel.fromJson(e)).toList();

      return state.copy(
        bidOnAdverts: adverts,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() => dispatch(WaitAction.add("get_bid_on_jobs"));

  @override
  void after() => dispatch(WaitAction.remove("get_bid_on_jobs"));
}

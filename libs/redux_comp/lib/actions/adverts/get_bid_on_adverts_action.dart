import 'dart:convert';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/advert_model.dart';

class GetBidOnAdvertsAction extends ReduxAction<AppState> {
  final String? tradesmanId;
  final bool archived;

  GetBidOnAdvertsAction({this.tradesmanId, this.archived = false});

  @override
  Future<AppState?> reduce() async {
    final String userId = tradesmanId ?? state.userDetails.id;

    String graphQLDocument = '''query {
      getBidOnAdverts(tradesman_id: "$userId", archived: $archived) {
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
        customer_id
        id
        images
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<dynamic> data = jsonDecode(response.data)['getBidOnAdverts'];
      List<AdvertModel> adverts =
          data.map((e) => AdvertModel.fromJson(e)).toList();

      if (archived) {
        return state.copy(
          archivedJobs: adverts,
        );
      } else {
        return state.copy(
          bidOnAdverts: adverts,
        );
      }
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() => dispatch(WaitAction.add("get_bid_on_jobs"));

  @override
  void after() => dispatch(WaitAction.remove("get_bid_on_jobs"));
}

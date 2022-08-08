import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';
import '../../models/advert_model.dart';

class ViewJobsAction extends ReduxAction<AppState> {
  final List<String> locations;
  final List<String> tradetypes;

  ViewJobsAction(this.locations, this.tradetypes);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewJobs(locations: ${jsonEncode(locations)}, types: ${jsonEncode(tradetypes)}) {
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

      return state.copy(
        viewAdverts: List.from(adverts),
        adverts: adverts,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() => dispatch(WaitAction.add("view_jobs"));

  @override
  void after() => dispatch(WaitAction.remove("view_jobs"));
}

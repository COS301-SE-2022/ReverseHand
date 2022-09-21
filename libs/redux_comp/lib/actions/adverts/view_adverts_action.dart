import 'dart:async';
import 'dart:convert';
import 'package:redux_comp/models/advert_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ViewAdvertsAction extends ReduxAction<AppState> {
  final bool archived;

  ViewAdvertsAction({this.archived = false});

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      viewAdverts(user_id: "${state.userDetails.id}", archived: $archived) {
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
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<AdvertModel> adverts = [];
      dynamic data = jsonDecode(response.data)['viewAdverts'];
      data.forEach((el) => adverts.add(AdvertModel.fromJson(el)));

      if (archived) {
        return state.copy(
          archivedJobs: adverts,
        );
      } else {
        return state.copy(
          adverts: adverts,
        );
      }
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() => dispatch(WaitAction.add("view_adverts"));

  @override
  void after() => dispatch(WaitAction.remove("view_adverts"));
}

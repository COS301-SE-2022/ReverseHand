import 'dart:convert';

import 'package:redux_comp/models/review_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetUserReviewsAction extends ReduxAction<AppState> {
  final String? userId;

  GetUserReviewsAction({this.userId});

  @override
  Future<AppState?> reduce() async {
    String userId = this.userId ?? state.userDetails.id;

    String graphQLDocument = '''query {
      getUserReviews(user_id: "$userId") {
        advert_id
        date_created
        description
        id
        rating
        user_id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      final List<dynamic> data = jsonDecode(response.data)['getUserReviews'];
      List<ReviewModel> reviews =
          data.map((el) => ReviewModel.fromJson(el)).toList();

      return state.copy(userDetails: state.userDetails.copy(reviews: reviews));
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() {
    // if there are currently chats the user may be viewing them and if a
    // new one comes in we don't want to hide everything and display a loading icon
    if (state.chats.isEmpty) dispatch(WaitAction.add("get_user_reviews"));
  }

  @override
  void after() => dispatch(WaitAction.remove("get_user_reviews"));
}

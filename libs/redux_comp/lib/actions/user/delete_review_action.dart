import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/redux_comp.dart';

class DeleteReviewAction extends ReduxAction<AppState> {
  final String userId;
  final String id; //review id

  DeleteReviewAction({required this.userId, required this.id});

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      deleteReview(
        user_id: "$userId",
        id: "$id"
      ){
        id
        advert_id
        description
        rating
        user_id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;
      final data = jsonDecode(response.data);

      //response is a list of reviews with the deleted one removed already
      return state.copy(reviews: data["deleteReview"]);
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToDeleteReview);
    }
  }
}

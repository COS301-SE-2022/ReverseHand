import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/review_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AddReviewAction extends ReduxAction<AppState> {
  final String userId;
  final ReviewModel review;

  AddReviewAction({required this.userId, required this.review});

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      addReview(
        user_id: "$userId",
        reviews: "${review.toString()}"
      ){
        id
        rating
        user_id
        description
        advert_id
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;

      //response is a list of reviews so just replace all the
      //current reviews with updated list from lambda
      return state.copy(reviews: response.data.addReview);
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToAddReview);
    }
  }
}

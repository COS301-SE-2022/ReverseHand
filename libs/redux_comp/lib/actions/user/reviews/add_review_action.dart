import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AddReviewAction extends ReduxAction<AppState> {
  final String description;
  final int rating;

  AddReviewAction({
    required this.description,
    required this.rating,
  });

  @override
  Future<AppState?> reduce() async {
    if (description.trim().isEmpty) {
      throw const UserException("", cause: ErrorType.reviewBadDescription);
    }

    String graphQLDocument = '''mutation {
      addReview(
        user_id: "${state.activeBid!.userId}",
        reviews: "{
          rating: $rating,
          description: $description
          user_id: ${state.userDetails.id}
          advert_id: ${state.activeAd!.id}
        }"
      ){
        id
        rating
        user_id
        description
        advert_id
        date_created
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      /* final response = */ Amplify.API.mutate(request: request).response;

      return null;
    } on ApiException catch (e) {
      debugPrint(e.message);
      throw const UserException("", cause: ErrorType.failedToAddReview);
    }
  }

  // sends error messages to CustomWrapError
  @override
  Object wrapError(error) {
    return error;
  }
}

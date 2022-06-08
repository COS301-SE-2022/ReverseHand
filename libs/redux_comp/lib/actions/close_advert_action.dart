import 'package:amplify_api/amplify_api.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class CloseAdvertAction extends ReduxAction<AppState> {
  
	final String adId;
  final String userId;

  CloseAdvertAction(this.userId, this.adId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      closeAdvert(user_id: "$userId", ad_id: "$adId") {
        advert_id
        user_id
        title
        description
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      // getting the bid which has beena accepted is just a graphql convention
      await Amplify.API
          .mutate(request: request)
          .response; // in futre may want to do something with accepted advert

      return state; // currently no change in state required
    } catch (e) {
      return state;
    } 


  }
}

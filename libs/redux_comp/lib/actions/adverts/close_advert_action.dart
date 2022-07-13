import 'package:amplify_api/amplify_api.dart';

import '../../app_state.dart';
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
      /* return the advert that was closed */
      await Amplify.API
          .mutate(request: request)
          .response; 

      return null; /* return null as we do not want to modify state as of now */ 
    } catch (e) {
      return null;
    } 


  }
}

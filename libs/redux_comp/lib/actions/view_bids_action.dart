import 'package:amplify_api/amplify_api.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ViewBidsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''
      query {
        viewBids
      }
    ''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    final response = await Amplify.API.query(request: request).response;
    print(response);

    return state;
  }
}

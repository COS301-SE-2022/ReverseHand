import 'dart:convert';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetPaystackSecretsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getPayStackKeys {
        secret_key
        public_key
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    final response = await Amplify.API.query(request: request).response;
    dynamic keys = json.decode(response.data)['getPayStackKeys'];

    return state.copy(
      paystackSecretKey: keys['secret_key'],
      paystackPublicKey: keys['public_key'],
    );
  }
}

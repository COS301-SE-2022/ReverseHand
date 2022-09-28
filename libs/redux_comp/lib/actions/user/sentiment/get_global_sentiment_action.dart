import 'dart:convert';

import 'package:redux_comp/models/sentiment_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetGlobalSentimentAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getGlobalSentiment {
        negative
        negative_messages
        neutral_messages
        positive
        positive_messages
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)['getGlobalSentiment'];

      return state.copy(
        globalSentiment: SentimentModel.fromJson(data),
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class DeleteChatAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      deleteChat(c_id: "${state.userDetails.id}", t_id: "${state.activeBid!.userId}", ad_id: "${state.activeAd!.id}") {
        id
        consumer_name
        tradesman_name
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;
      debugPrint(response.data);

      return null;
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void after() {
    dispatch(ViewAdvertsAction());
    dispatch(GetChatsAction());
  }
}

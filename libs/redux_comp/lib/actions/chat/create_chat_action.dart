import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/bid_model.dart';
import '../../app_state.dart';

class CreateChatAction extends ReduxAction<AppState> {
  final String tradesmanId; // since consumerId is stored in state

  CreateChatAction(this.tradesmanId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      createChat(c_id: "${state.userDetails!.id}", t_id: "$tradesmanId") {
        consumer_id
        tradesman_id
        messages {
          msg
          sender
          timestamp
          consumer_id // duplicate used for subscription
          tradesman_id
        }
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      // getting the bid which has beena accepted is just a graphql convention
      await Amplify.API
          .mutate(request: request)
          .response; // in future may want to do something with accepted advert

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    dispatch(GetChatsAction());
    dispatch(NavigateAction.pushReplacementNamed("/consumer"));
  } // after bid has been accepted no more to do so leave page and got to main page
}

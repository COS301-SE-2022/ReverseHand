import 'package:redux_comp/actions/chat/get_chats_action.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';

class CreateChatAction extends ReduxAction<AppState> {
  final String tradesmanId; // since consumerId is stored in state

  CreateChatAction(this.tradesmanId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      createChat(c_id: "${state.userDetails!.id}", t_id: "$tradesmanId", c_name: "${state.userDetails!.name}", t_name: "${state.activeBid!.name}") {
        consumer_id
        tradesman_id
        consumer_name
        tradesman_name
        messages {
          msg
          sender
          timestamp
          consumer_id
          tradesman_id
          name
        }
      }
    }'''; // duplicate used for subscription

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      // getting the bid which has beena accepted is just a graphql convention
      /* dynamic response = */ await Amplify.API
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
  } // after bid has been accepted, there is nothing more to do so leave page and go to main page
}

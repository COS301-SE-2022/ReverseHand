import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/actions/chat/create_chat_action.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';

class AcceptBidAction extends ReduxAction<AppState> {
  AcceptBidAction();

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation {
      acceptBid(ad_id: "${state.activeAd!.id}", sbid_id: "${state.activeBid!.id}") {
        id
        tradesman_id
        name
        price
        quote
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      // getting the bid which has beena accepted is just a graphql convention
      dynamic response = await Amplify.API
          .mutate(request: request)
          .response; // in future may want to do something with accepted advert

      // dispatching action to create chat
      dispatch(CreateChatAction(state.activeBid!.userId));

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    dispatch(ViewAdvertsAction());
    dispatch(NavigateAction.pushReplacementNamed("/consumer"));
  } // after bid has been accepted no more to do so leave page and got to main page
}

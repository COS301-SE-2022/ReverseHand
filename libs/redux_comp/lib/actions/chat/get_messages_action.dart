import 'package:redux_comp/models/chat/chat_model.dart';
import '../../app_state.dart';

import 'package:async_redux/async_redux.dart';

class GetMessagesAction extends ReduxAction<AppState> {
  final ChatModel chat; // the chat whose messages must be retrieved

  GetMessagesAction(this.chat);

  @override
  AppState? reduce() {
    return state.copy(chat: chat);
  }

  // in after dispatch action to create subscription
}

import 'dart:convert';
import 'package:redux_comp/models/user_models/notification_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetNotificationsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getNotifications(user_id: "${state.userDetails.id}") {
        title
        msg
        type
        timestamp
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      List<NotificationModel> notifications = [];
      final data = jsonDecode(response.data)['getNotifications'];
      data.forEach((el) => notifications.add(NotificationModel.fromJson(el)));

      return state.copy(
        notifications: notifications.reversed.toList(),
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }

  @override
  void before() {
    // if there are currently notifications the user may be viewing them and if a
    // new one comes in we don't want to hide everything and display a loading icon
    if (state.notifications.isEmpty) dispatch(WaitAction.add("get_notifs"));
  }

  @override
  void after() => dispatch(WaitAction.remove("get_notifs"));
}

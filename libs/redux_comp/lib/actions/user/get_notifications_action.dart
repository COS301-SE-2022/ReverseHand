import 'dart:convert';
import 'package:redux_comp/models/user_models/notification_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetNotificationsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getNotifications(user_id: "${state.userDetails!.id}") {
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
        notifications: notifications,
      );
    } catch (e) {
      return null; /* On Error do not modify state */
    }
  }
}
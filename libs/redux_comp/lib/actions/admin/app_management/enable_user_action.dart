import 'package:flutter/material.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EnableUserAction extends ReduxAction<AppState> {
  final String username;
  final bool disable;
  EnableUserAction({required this.username, required this.disable});

	@override
	Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation {
      enableUser(disable: $disable, username: "$username")
    }''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      await Amplify.API.query(request: request).response;
      
      return state.copy(
        admin: state.admin.copy(
          adminManage: state.admin.adminManage.copy(
            activeUser: state.admin.adminManage.activeUser!.copy(
              enabled: (disable) ? false : true
            ),
          ),
        ),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void before() => dispatch(WaitAction.add("enable_user"));

  @override
  void after() => dispatch(WaitAction.remove("enable_user"));
}


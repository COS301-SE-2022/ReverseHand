import 'dart:async';

import 'package:amplify/models/Consumer.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/app_state.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      final request = ModelQueries.list(Consumer.classType,
          where: Consumer.EMAIL.contains(email));

      final response = await Amplify.API.query(request: request).response;

      print(response.data!.items[0]!.name);
      return state.replace(name: response.data!.items[0]!.name);
    } on ApiException catch (e) {
      print(
          'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }
  }
}

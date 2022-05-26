// import 'package:amplify/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
// import 'package:flutter/foundation.dart';
// import 'package:redux_comp/models/user_models/consumer_model.dart';
import '../app_state.dart';

class RegisterUserAction extends ReduxAction<AppState> {
  final String username;
  final String password;

  RegisterUserAction(this.username, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      // Map<CognitoUserAttributeKey, String> userAttributes = {
      //   CognitoUserAttributeKey.email: 'email@domain.com',
      //   // additional attributes as needed
      // };
      // final userPool = CognitoUserPool(
      //   'ap-southeast-1_xxxxxxxxx',
      //   'k165j5iid3jlctq8uv2naigue',
      // );
      // final userAttributes = [
      //   const AttributeArg(name: 'first_name', value: 'Jimmy'),
      //   const AttributeArg(name: 'last_name', value: 'Wong'),
      // ];

      // /*CognitoUserPoolData res = */ await userPool.signUp(
      //   'email@inspire.my',
      //   'Password001',
      //   userAttributes: userAttributes,
      // );

      return state;
    } catch (e) {
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }
}

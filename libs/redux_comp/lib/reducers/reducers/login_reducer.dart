import 'package:amplify/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/app_state.dart';

class LoginAction {
  final String email;
  final String password;

  LoginAction(this.email, this.password);
}

Future<AppState> loginReducer(AppState state, LoginAction action) async {
  try {
    final request = ModelQueries.list(Consumer.classType,
        where: Consumer.EMAIL.contains(action.email));

    final response = await Amplify.API.query(request: request).response;

    print(response.data!.items[0]!.name);
    return state.replace(name: response.data!.items[0]!.name);
  } on ApiException catch (e) {
    print(
        'Getting data failed $e'); // temp fix later, add error to store, through error class
    return state;
  }
}

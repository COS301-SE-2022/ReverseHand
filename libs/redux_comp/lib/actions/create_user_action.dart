import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux_comp/models/error_type_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class CreateUserAction extends ReduxAction<AppState> {
	@override
	Future<AppState?> reduce() async {

    if (state.partialUser!.verified == "DONE") {
        final String name = state.partialUser!.email;
        final String id = (state.partialUser!.group == "customer") ? "c#${state.partialUser!.id}" : "t#${state.partialUser!.id}";
        final double lat = state.partialUser!.place!.location!.lat!;
        final double long = state.partialUser!.place!.location!.long!;

        String graphQLDocTwo = '''mutation  {
          createUser(lat: "$lat", long: "$long", name: "$name", user_id: "$id") {
            id
          }
        }
        ''';

        final requestCreateUser = GraphQLRequest(
          document: graphQLDocTwo,
        );

        try {
          await Amplify.API.mutate(request: requestCreateUser).response;
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
    } else {
      return state.replace(
        error: ErrorType.failedToCreateUser
      );
    }
  }
}

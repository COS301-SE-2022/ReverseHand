import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux_comp/actions/login_action.dart';
import 'package:redux_comp/models/error_type_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class CreateUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.partialUser!.verified == "DONE") {
      final String email = state.partialUser!.email;
      final String name = state.partialUser!.name!;
      final String cellNo = state.partialUser!.cellNo!;
      final String id = state.partialUser!.id!;
      final double lat = state.partialUser!.place!.location!.lat!;
      final double long = state.partialUser!.place!.location!.long!;
      final String streetnumber = state.partialUser!.place!.streetNumber!;
      final String street = state.partialUser!.place!.street!;
      final String city = state.partialUser!.place!.city!;
      final String zipCode = state.partialUser!.place!.zipCode!;

      if (state.partialUser!.group == "tradesman") {
        String graphQLDoc = '''mutation  {
          createUser(cellNo: "$cellNo", city: "$city", email: "$email", lat: "$lat", long: "$long", name: "$name", streetNumber: "$streetnumber", user_id: "$id", zipCode: "$zipCode", domains: "["$city"]", street: "$street", tradetypes: "["Painting", "Plumbing"]") {
            id
          }
        }
        ''';

        final requestCreateUser = GraphQLRequest(
          document: graphQLDoc,
        );

        try {
          await Amplify.API.mutate(request: requestCreateUser).response;
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
      } else {
        String graphQLDoc = '''mutation  {
          createUser(cellNo: "$cellNo", city: "$city", email: "$email", lat: "$lat", long: "$long", name: "$name", streetNumber: "$streetnumber", user_id: "$id", zipCode: "$zipCode", street: "$street") {
            id
          }
        }
        ''';

        final requestCreateUser = GraphQLRequest(
          document: graphQLDoc,
        );

        try {
          final resp = await Amplify.API.mutate(request: requestCreateUser).response;
          debugPrint(resp.data);
          return null;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }
      }
    } else {
      return state.replace(error: ErrorType.failedToCreateUser);
    }
  }

  @override
  void after() async {
    await dispatch(LoginAction(state.partialUser!.email, state.partialUser!.password!));
  }
}

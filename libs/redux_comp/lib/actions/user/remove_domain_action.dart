import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/geolocation/domain_model.dart';

/* Remove domain from a user */
/* requires the city as well as the suer ID */

class RemoveDomainAction extends ReduxAction<AppState> {
  final String city;

  RemoveDomainAction(this.city);

  @override
  Future<AppState?> reduce() async {
    /* If the user is verified then the signUpStep is DONE, so we just update the partial user model and add the user to the correct group*/
    String graphQLDoc = '''
      mutation {
        removeDomain(id: "$state.userDetails!.id", city: "$city")
      }
    ''';

    final requestUserGroup = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      await Amplify.API.mutate(request: requestUserGroup).response;

      List<Domain> domains = state.userDetails!.domains;
      domains.removeWhere((element) => element.city == city);

      return state.copy(userDetails: state.userDetails!.copy(domains: domains));
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}

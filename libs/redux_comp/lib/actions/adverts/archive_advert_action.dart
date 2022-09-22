import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

// this actiona archives an advert early

class ArchiveAdvertAction extends ReduxAction<AppState> {
  final String?
      advertId; // will be used if passed in otherwise will use activeAd

  ArchiveAdvertAction({this.advertId});

  @override
  Future<AppState?> reduce() async {
    final String graphQLDocument = '''mutation {
      archiveAdvert(ad_id: "${advertId ?? state.activeAd!.id}") {
        id
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      // getting the bid which has beena accepted is just a graphql convention
      final response = await Amplify.API
          .mutate(request: request)
          .response; // in future may want to do something with accepted advert
      debugPrint(response.data);

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void after() => dispatch(ViewAdvertsAction());
}

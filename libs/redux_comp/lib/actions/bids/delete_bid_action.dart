import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class DeleteBidAction extends ReduxAction<AppState> {
  final String advertId;
  final String bidId;

  DeleteBidAction(this.advertId, this.bidId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = ''' mutation {
      deleteBid(ad_id: "$advertId",bid_id:"$bidId")
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.mutate(request: request).response;
      debugPrint(response.data);
      return null;
    } catch (e) {
      return null;
    }
  }
}

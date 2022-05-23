import 'package:amplify_api/model_queries.dart';
import 'package:redux_comp/models/user_models/consumer_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:amplify/models/Bid.dart';

class ViewBidsConsumerAction extends ReduxAction<AppState> {
  final String _advertId;

  ViewBidsConsumerAction(this._advertId);

  @override
  Future<AppState?> reduce() async {
    try {
      final request = ModelQueries.list<Bid>(Bid.classType,
          where: Bid.ADVERTID.eq(_advertId));
      final repsonse = await Amplify.API.query(request: request).response;

      List<Bid?>? nullBids = repsonse.data?.items;

      if (nullBids == null) {
        // error should be reported
        return state;
      }

      List<Bid> bids = [];

      for (int i = 0; i < nullBids!.length; i++) {
        bids.add(nullBids[i]!);
      }

      return state.replace(
          user: (state.user as ConsumerModel).replace(bids: bids));
    } catch (e) {
      return state;
    }
  }
}

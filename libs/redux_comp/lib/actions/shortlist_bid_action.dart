import '../app_state.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ShortlistBidAction extends ReduxAction<AppState> {
  final String adId;
  final String bidId;

  ShortlistBidAction(this.adId, this.bidId);

  @override
  Future<AppState?> reduce() async {
    return state; // temporary remove
  }
}

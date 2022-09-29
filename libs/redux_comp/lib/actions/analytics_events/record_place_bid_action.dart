import 'package:flutter/material.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class RecordPlaceBidAction extends ReduxAction<AppState> {
  String type;
  int amount;

  RecordPlaceBidAction({required this.type, required this.amount});

  @override
  Future<AppState?> reduce() async {
    final event = AnalyticsEvent('PlaceBid');

    event.properties.addStringProperty('job_type', type);
    event.properties.addIntProperty('amount', amount);

    try {
      await Amplify.Analytics.recordEvent(event: event);
      await Amplify.Analytics.flushEvents();
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}

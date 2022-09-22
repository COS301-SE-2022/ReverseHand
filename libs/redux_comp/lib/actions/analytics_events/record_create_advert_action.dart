import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class RecordCreateAdvertAction extends ReduxAction<AppState> {
  String city;
  String province;

  RecordCreateAdvertAction({required this.city, required this.province});

  @override
  Future<AppState?> reduce() async {
    final AnalyticsEvent event = AnalyticsEvent('CreateAdvert');

    event.properties.addStringProperty('city', city);
    event.properties.addStringProperty('province', province);

    print(event.properties.getAllProperties());
    try {
      await Amplify.Analytics.recordEvent(event: event);
      await Amplify.Analytics.flushEvents();
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}

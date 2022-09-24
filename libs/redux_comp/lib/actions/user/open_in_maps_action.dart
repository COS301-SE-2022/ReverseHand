import 'package:flutter/material.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:maps_launcher/maps_launcher.dart';

// opens the maps app to the specified location of the current ad
class OpenInMapsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final bool result =
        await MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
    debugPrint(result.toString());
    return null;
  }
}

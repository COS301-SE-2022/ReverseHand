import 'package:geolocator/geolocator.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetGeolocationPermissionAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    /// Determine the current position of the device.
    ///
    /// When the location services are not enabled or permissions
    /// are denied the `Future` will return an error.
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return state.copy(error: ErrorType.localPermissionDenied);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return state.copy(error: ErrorType.localPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return state.copy(error: ErrorType.localPermissionDenied);
    }

    return null;
  }
}

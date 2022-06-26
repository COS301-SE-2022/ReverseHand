import '../app_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:async_redux/async_redux.dart';

class GetAddressAction extends ReduxAction<AppState> {

  GetAddressAction();
  
	@override
	Future<AppState?> reduce() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true);
      List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);

      Placemark place = placemarks[0];

      Map<String, dynamic> address = place.toJson();

      return null;
    } catch (e) {
      return null;
    }
  }
}

import '../app_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:async_redux/async_redux.dart';

class GetAddressAction extends ReduxAction<AppState> {

  
	@override
	Future<AppState?> reduce() async {
    bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
    try {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      // Could be useful later
      // List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      // Placemark place = placemarks[0];
      // Map<String, dynamic> address = place.toJson();

      return state.replace(
        partialUser: state.partialUser!.replace(position: pos)
      );

  
    } catch (e) {
      return null;
    }
  }
}

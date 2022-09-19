import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:redux_comp/actions/geolocation/get_geolocation_permission_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/filter_adverts_model.dart';

// code to filter and sort adverts
// user cannot be null

class FilterAdvertsAction extends ReduxAction<AppState> {
  final FilterAdvertsModel filter;

  FilterAdvertsAction(this.filter);

  @override
  Future<AppState?> reduce() async {
    List<AdvertModel> adverts = List.from(state.adverts);

    if (filter.domains != null) {
      for (MapEntry<int, AdvertModel> entrey in state.adverts.asMap().entries) {
        if (!filter.domains!.contains(entrey.value.domain.city)) {
          adverts.remove(entrey.value);
        }
      }
    }

    if (filter.tradeTypes != null) {
      for (AdvertModel advert in state.adverts) {
        if (!filter.tradeTypes!.contains(advert.type)) {
          adverts.remove(advert);
        }
      }
    }

    if (filter.sort != null) {
      if (filter.sort!.direction == Direction.ascending) {
        adverts.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
      } else {
        adverts.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      }
    }

    // filter by distance
    if (filter.distance != null) {
      await dispatch(GetGeolocationPermissionAction());
      // check for errors here
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Coordinates currentPosition =
          Coordinates(lat: position.latitude, lng: position.longitude);
      adverts.removeWhere(
        (advert) =>
            _calculateDistance(advert.domain.coordinates, currentPosition) >
            filter.distance!,
      );
    }

    return state.copy(
      viewAdverts: adverts,
    );
  }
}

// Haversine formula
// function to calculate distance between two points
double _calculateDistance(Coordinates p1, Coordinates p2) {
  const double conversionConstant = pi / 180; // convert degrees to radians
  const double radiusOfEarth = 6378.8; // in km

  // return distance;*
  final double dLat = (p2.lat - p1.lat) * conversionConstant;
  final double dLon = (p2.lng - p1.lng) * conversionConstant;
  final double lat1 = p1.lat * conversionConstant;
  final double lat2 = p2.lat * conversionConstant;

  final double distance = radiusOfEarth *
      (2 *
          asin(sqrt(pow(sin(dLat / 2), 2) +
              pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2))));
  return distance;

  //3963.0 * arccos[(sin(lat1) * sin(lat2)) + cos(lat1) * cos(lat2) * cos(long2 – long1)]
}

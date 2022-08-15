// code to filter and sort adverts
// user cannot be null

import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:redux_comp/actions/geolocation/get_geolocation_permission_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/filter_adverts_model.dart';

class FilterAdvertsAction extends ReduxAction<AppState> {
  final FilterAdvertsModel filter;

  FilterAdvertsAction(this.filter);

  @override
  Future<AppState?> reduce() async {
    List<AdvertModel> adverts = [];

    if (filter.domains != null) {
      for (AdvertModel advert in state.adverts) {
        if (filter.domains!.contains(advert.domain)) {
          adverts.add(advert);
        }
      }
    }

    if (filter.jobTypes != null) {
      for (AdvertModel advert in state.adverts) {
        if (filter.jobTypes!.contains(advert.type)) {
          adverts.add(advert);
        }
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

// function to calculate distance between two points
double _calculateDistance(Coordinates p1, Coordinates p2) {
  return sqrt(((p1.lat - p2.lat) * (p1.lat - p2.lat)) +
      ((p1.lng - p2.lng) * (p1.lng - p2.lng)));
}

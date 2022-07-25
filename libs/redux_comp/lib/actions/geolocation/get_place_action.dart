import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/geolocation/suggestion_model.dart';

class GetPlaceAction extends ReduxAction<AppState> {
  Suggestion input;
  PlaceApiService placeApi;

  GetPlaceAction(this.input, this.placeApi);

  @override
  Future<AppState?> reduce() async {
    try {
      Location result = await placeApi.getPlaceDetailFromId(input.placeId);
      switch (state.userDetails!.userType) {
        case "Consumer":
          return state.copy(
            userDetails: state.userDetails!.copy(location: result),
          );
        case "Tradesman":
          List<Domain> userDomains = state.userDetails!.domains;
          userDomains.add(Domain(
            city: result.address.city,
            coordinates: Coordinates(
                lat: result.coordinates.lat, lng: result.coordinates.lng),
          ));
          return state.copy(
            userDetails: state.userDetails!.copy(domains: userDomains,location: result),
          );
        default:
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    dispatch(NavigateAction.pushNamed('/tradesman/location_confirm'));
  }
}

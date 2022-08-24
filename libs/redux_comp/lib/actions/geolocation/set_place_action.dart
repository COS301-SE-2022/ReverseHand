import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetPlaceAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.locationResult != null) {
      switch (state.userDetails!.userType) {
        case "Consumer":
          return state.copy(
            userDetails:
                state.userDetails!.copy(location: state.locationResult),
          );
        case "Tradesman":
          List<Domain> userDomains = List.from(state.userDetails!.domains);
          userDomains.add(Domain(
            city: state.locationResult!.address.city,
            coordinates: Coordinates(
                lat: state.locationResult!.coordinates.lat,
                lng: state.locationResult!.coordinates.lng),
          ));
          return state.copy(
            userDetails:
                state.userDetails!.copy(domains: userDomains, location: state.locationResult),
          );
        default:
          return null;
      }
    } else {
      return state.copy(error: ErrorType.locationNotCaptured);
    }
  }

  @override
  void after() {
    PlaceApiSingleton.instance.destroy();
    dispatch(NavigateAction.pop());
  }
}

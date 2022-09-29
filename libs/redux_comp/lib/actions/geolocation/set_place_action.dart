import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/actions/user/user_table/edit_user_details_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetPlaceAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.locationResult != null) {
      switch (state.userDetails.userType) {
        case "Consumer":
          dispatch(EditUserDetailsAction(
              userId: state.userDetails.id,
              changed: "location",
              location: state.locationResult));
          return state.copy(
            userDetails: state.userDetails.copy(location: state.locationResult),
          );
        case "Tradesman":
          List<Domain> userDomains = List.from(state.userDetails.domains);
          userDomains.add(Domain(
            city: state.locationResult!.address.city,
            province: state.locationResult!.address.province,
            coordinates: Coordinates(
                lat: state.locationResult!.coordinates.lat,
                lng: state.locationResult!.coordinates.lng),
          ));
          dispatch(EditUserDetailsAction(
              userId: state.userDetails.id,
              changed: "domains",
              domains: userDomains));
          return state.copy(
            userDetails: state.userDetails
                .copy(domains: userDomains, location: state.locationResult),
          );
        default:
          return null;
      }
    } else {
      throw const UserException("", cause: ErrorType.locationNotCaptured);
    }
  }

  @override
  void after() {
    PlaceApiSingleton.instance.destroy();
    dispatch(NavigateAction.pop());
  }

  // sends error messages to CustomWrapError
  @override
  Object wrapError(error) {
    return error;
  }
}

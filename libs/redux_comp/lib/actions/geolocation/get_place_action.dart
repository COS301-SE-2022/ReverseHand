import 'package:geolocation/place_api_service.dart';
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

      return state.copy(locationResult: result);
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    (state.userDetails!.userType == "Tradesman")
        ? dispatch(NavigateAction.pushNamed('/tradesman/location_confirm'))
        : dispatch(NavigateAction.pushNamed('/consumer/location_confirm'));
  }
}

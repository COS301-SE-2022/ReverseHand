import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:geolocation/place_api_service.dart';

class GetPlaceAction extends ReduxAction<AppState> {

  Suggestion input;
  PlaceApiService placeApi;

  GetPlaceAction(this.input, this.placeApi);

	@override
	Future<AppState?> reduce() async {
    try {
      // Place result = await placeApi.getPlaceDetailFromId(input.placeId);

      Place result = Place(streetNumber: "318", street: "The Rand", city: "Pretoria", zipCode: "0102", location: const Coordinates(lat: 22.23, long: 25.34));

      return state.replace(
        partialUser: state.partialUser!.replace(
          place: result
        )
      );
    } catch (e) {
      return null;
    }
  }
}

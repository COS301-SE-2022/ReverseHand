import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:geolocation/place_api_service.dart';

class GetPLaceAction extends ReduxAction<AppState> {

  Suggestion input;
  PlaceApiService placeApi;

  GetPLaceAction(this.input, this.placeApi);

	@override
	Future<AppState?> reduce() async {
    try {
      Place result = await placeApi.getPlaceDetailFromId(input.placeId);

      return state.replace(
        geo: state.geo!.replace(
          result: result
        )
      );
    } catch (e) {
      return null;
    }
  }
}

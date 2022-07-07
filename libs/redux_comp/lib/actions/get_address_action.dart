
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

import '../models/geolocation/suggestion_model.dart';
import 'package:geolocation/place_api_service.dart';

class GetAddressAction extends ReduxAction<AppState> {
  String input;
  PlaceApiService placeApi;

  GetAddressAction(this.input, this.placeApi);

  @override
  Future<AppState?> reduce() async {
    try {
      List<Suggestion> l = await placeApi.fetchSuggestions(input);
      return state.replace(
        geo: state.geo!.replace(
          suggestions: l
        )
      );
    } catch (e) {
      return null;
    }


  }
}


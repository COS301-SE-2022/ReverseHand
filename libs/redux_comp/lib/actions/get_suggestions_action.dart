import 'package:redux_comp/models/geolocation/suggestion_model.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:geolocation/place_api_service.dart';

class GetSuggestionsAction extends ReduxAction<AppState> {

  String input;
  PlaceApiService placeApi;

  GetSuggestionsAction(this.input, this.placeApi);

	@override
	Future<AppState?> reduce() async {
    try {
      List<Suggestion> suggestions = await placeApi.fetchSuggestions(input);

      return state.replace(
        geo: state.geo!.replace(
          suggestions: suggestions
        )
      );
    } catch (e) {
      return null;
    }
  }
}

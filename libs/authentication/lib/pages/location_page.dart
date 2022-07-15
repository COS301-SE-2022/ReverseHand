import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/geolocation/get_place_action.dart';
import 'package:redux_comp/actions/geolocation/get_suggestions_action.dart';
// import 'package:general/general.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/redux_comp.dart';

class AddressSearch extends SearchDelegate<Place?> {
  final String sessionToken;
  PlaceApiService apiClient;
  Suggestion? suggestion;
  final Store<AppState> store;

  AddressSearch(this.sessionToken, this.store)
      : apiClient = PlaceApiService(sessionToken);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  
  @override
  Widget buildResults(BuildContext context) {
    return Text(
      suggestion!.description,
    ); //TO-DO: put result page here, make api call to place details, lat and long to focus on those coords
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    store.dispatch(GetSuggestionsAction(query, apiClient));
    if (store.state.suggestions.isEmpty && query.length < 3) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Enter your address'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text((store.state.suggestions[index]).description),
          onTap: () {
            suggestion = store.state.suggestions[index];
            store.dispatch(GetPlaceAction(suggestion!, apiClient));
            buildResults(context);

          },
        ),
        itemCount: store.state.suggestions.length,
      );
    }
  }

}

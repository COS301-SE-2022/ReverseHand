import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/geolocation/get_place_action.dart';
import 'package:redux_comp/actions/geolocation/get_suggestions_action.dart';
// import 'package:general/general.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/redux_comp.dart';

class LocationSearchPage extends SearchDelegate<Suggestion?> {
  final String sessionToken;
  PlaceApiService apiClient;
  Suggestion? suggestion;
  final Store<AppState> store;

  LocationSearchPage(this.sessionToken, this.store)
      : apiClient = PlaceApiService(sessionToken) {
        query = "";
      }

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
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
       store.dispatch(GetSuggestionsAction(query, apiClient));
    }
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
            close(context, suggestion);
          },
        ),
        itemCount: store.state.suggestions.length,
      );
    }
  }
}

//318 The Rand 
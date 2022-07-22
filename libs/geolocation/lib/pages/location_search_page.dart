import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/geolocation/get_place_action.dart';
import 'package:redux_comp/actions/geolocation/get_suggestions_action.dart';
import 'package:redux_comp/models/geolocation/search_model.dart';
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
    store.state.copy(geoSearch: const GeoSearch(suggestions: []));
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
    return StoreConnector<AppState, _ViewModel>(
      vm: () => _Factory(this),
      builder: (BuildContext context, _ViewModel vm) {
        if (query.length > 5) {
          vm.dispatchGetSuggestionsAction("318 The Rand", apiClient);
          if (vm.suggestions.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                  title: Text((vm.suggestions[index]).description),
                  onTap: () {
                    final suggestion = vm.suggestions[index];
                    vm.dispatchGetPlaceAction(suggestion, apiClient);
                    close(context, suggestion);
                  }),
              itemCount: vm.suggestions.length,
            );
          } else {
            return const Text("loading");
          }
        } else {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text('Please enter your street address'),
          );
        }
      },
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LocationSearchPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      suggestions: state.geoSearch!.suggestions,
      dispatchGetPlaceAction: (input, placeApi) =>
          dispatch(GetPlaceAction(input, placeApi)),
      dispatchGetSuggestionsAction: (input, placeApi) =>
          dispatch(GetSuggestionsAction(input, placeApi)));
}

// view model
class _ViewModel extends Vm {
  final List<Suggestion> suggestions;
  final void Function(Suggestion, PlaceApiService) dispatchGetPlaceAction;
  final void Function(String, PlaceApiService)  dispatchGetSuggestionsAction;

  _ViewModel({
    required this.dispatchGetPlaceAction,
    required this.dispatchGetSuggestionsAction,
    required this.suggestions,
  }): super(equals: [suggestions]);
}

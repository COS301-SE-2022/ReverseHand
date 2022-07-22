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
  List<Suggestion>? suggestions;
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
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<Suggestion>> snapshot) =>
              query == ''
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text('Enter your address'),
                    )
                  : snapshot.hasData
                      ? StoreConnector<AppState, _ViewModel> (
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) => ListView.builder(
                            itemBuilder: (context, index) => ListTile(
                              title: Text((snapshot.data![index]).description),
                              onTap: () {
                                vm.dispatchGetPlaceAction(snapshot.data![index], apiClient);
                                close(context, snapshot.data![index]);
                              },
                            ),
                            itemCount: snapshot.data!.length,
                          ),
                      )
                      : const Text('Loading...'),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LocationSearchPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      dispatchGetPlaceAction: (input, placeApi) =>
          dispatch(GetPlaceAction(input, placeApi)));
}

// view model
class _ViewModel extends Vm {
  final void Function(Suggestion, PlaceApiService) dispatchGetPlaceAction;

  _ViewModel({
    required this.dispatchGetPlaceAction,
  });
}

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
// import 'package:general/general.dart';
import 'package:redux_comp/actions/get_place_action.dart';
import 'package:redux_comp/actions/get_suggestions_action.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/redux_comp.dart';

class AddressSearch extends SearchDelegate<Suggestion?> {
  final int sessionToken;
  PlaceApiService apiClient;
  Suggestion? suggestion;
  final Store<AppState> store;

  AddressSearch(this.sessionToken, this.store) : apiClient = PlaceApiService(sessionToken);

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
    if(store.state.geo!.suggestions!.isEmpty && query == "") {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Enter your address'
        ),
      );
    }
    else {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
              Text((store.state.geo!.suggestions![index]).description),
          onTap: () {
            suggestion = store.state.geo!.suggestions![index];
            buildResults(context);
          },
        ),
        itemCount: store.state.geo!.suggestions!.length,
      );
    }
  }
}

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, AddressSearch> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushSignUpPage: () => dispatch(NavigateAction.pushNamed('/signup')),
        dispatchGetSuggestionsAction: (String input, PlaceApiService api) => dispatch(
          GetSuggestionsAction(input, api),
        ),
        dispatchGetPlaceAction: (Suggestion suggestion, PlaceApiService api) => dispatch(
          GetPlaceAction(suggestion, api),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, PlaceApiService) dispatchGetSuggestionsAction;
  final void Function(Suggestion, PlaceApiService) dispatchGetPlaceAction;
  final VoidCallback pushSignUpPage;

  _ViewModel({
    required this.dispatchGetSuggestionsAction,
    required this.dispatchGetPlaceAction,
    required this.pushSignUpPage,
  });
}

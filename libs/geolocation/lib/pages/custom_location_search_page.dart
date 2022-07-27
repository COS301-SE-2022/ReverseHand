import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/place_api_service.dart';
import 'package:redux_comp/actions/geolocation/get_place_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

class CustomLocationSearchPage extends StatefulWidget {
  final Store<AppState> store;

  const CustomLocationSearchPage({Key? key, required this.store})
      : super(key: key);

  @override
  State<CustomLocationSearchPage> createState() =>
      _CustomLocationSearchPageState();
}

class _CustomLocationSearchPageState extends State<CustomLocationSearchPage> {
  final searchController = TextEditingController();
    String searchString = "";

  Future<List<Suggestion>>? _searchFuture;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //theoritically this code should be in the constructor, but the passed in sessionToken is only available in the build method
    String? sessionToken =
        (ModalRoute.of(context)?.settings.arguments) as String?; //fetch the session token passed in
    (sessionToken == null) ? sessionToken = "1234" : null;
    final PlaceApiService apiClient = PlaceApiService(sessionToken);  //instantiate the api service

    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              controller: searchController,
              onChanged: (text) { //when the input text has changed
                setState(() {
                  searchString = text;  //assign to searchString
                  (searchString.length % 3 == 0)    //only make a request every 3 character input
                      ? _searchFuture = searchString.length > 8 //dont make a request before 8 chars
                          ? apiClient.fetchSuggestions(searchString) // ^^^ this is for cost optimisation
                          : null
                      : null;
                });
              }),
        ),
      )),
      body: FutureBuilder(
        future: _searchFuture,
        builder: (BuildContext context,
                AsyncSnapshot<List<Suggestion>> snapshot) =>
            (searchString.isEmpty) // if the search string is empty
                ? Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text('Please enter your full address'), // ask for address
                  )
                : snapshot.hasData  // if we have data do display, build a list of suggestions
                    ? StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            title: Text((snapshot.data![index]).description),
                            onTap: () { // when a user taps on a suggestions
                              vm.dispatchGetPlaceAction(
                                  snapshot.data![index], apiClient);    //get the details of the suggestion
                            },
                          ),
                          itemCount: snapshot.data!.length,
                        ),
                      )
                    : snapshot.hasError //if there is an error
                        ? const Text("Error") //display for now
                        : const Center(
                            child: CircularProgressIndicator(), // else show loading indicator
                          ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, _CustomLocationSearchPageState> {
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

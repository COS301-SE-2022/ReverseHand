import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/advert_model.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EditAdvertAction extends ReduxAction<AppState> {
  final String advertId;
  final String description;
  final String type;
  final String location;
  final String dateClosed;
  final String title;

  EditAdvertAction(this.advertId, this.description, this.type, this.location,
      this.dateClosed, this.title);
  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation { 
      editAdvert(ad_id: "$advertId"){
        title: "$title",
        description: "$description",
        type: "$type",
        location: "$location",
        date_closed: "$dateClosed"
      }
    } ''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      await Amplify.API.mutate(request: request).response;

      List<AdvertModel> adverts = state.adverts;

      //get the advert being edited
      AdvertModel ad = adverts.firstWhere((element) => element.id == advertId);

      //remove it from the current list of adverts then create a new one
      //with the updated details.
      //There could potentially be a better way to do this perhaps??
      //Problem is fields are final so cant change them in the original one
      adverts.removeWhere((element) => element.id == advertId);

      //add the updated details as a new advert.
      adverts.add(AdvertModel(
          id: ad.id,
          title: ad.title,
          dateCreated: ad.dateCreated,
          description: description,
          type: type,
          location: location,
          dateClosed: dateClosed));

      return state.copy(adverts: adverts);
    } catch (e) {
      return null;
    }
  }
}

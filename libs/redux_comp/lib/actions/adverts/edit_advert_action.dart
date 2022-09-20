import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class EditAdvertAction extends ReduxAction<AppState> {
  final String advertId;
  final String? description;
  final String? type;
  final Domain? domain;
  final String? title;

  EditAdvertAction({
    required this.advertId,
    this.description,
    this.type,
    this.domain,
    this.title,
  });

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''mutation { 
      editAdvert(ad_id: "$advertId",title: "$title",description: "$description", domain: ${domain.toString()}){
        id
      }
    } ''';

    final request = GraphQLRequest(document: graphQLDocument);
    try {
      //commented cause it was unused
      dynamic response = await Amplify.API.mutate(request: request).response;

      if (response.errors.isNotEmpty) {
        switch (response.errors[0].message) {
          case "Advert contains bids":
            throw const UserException("", cause: ErrorType.advertContainsBids);
        }
      }

      List<AdvertModel> adverts = state.adverts;

      //get the advert being edited
      int adPos = adverts.indexWhere((element) => element.id == advertId);

      // remove it from the current list of adverts then create a new one
      // with the updated details.
      // There could potentially be a better way to do this perhaps??
      // Problem is fields are final so cant change them in the original one
      // adverts.removeWhere((element) => element.id == advertId);

      // //add the updated details as a new advert.
      // adverts.add(
      // AdvertModel(
      //   id: ad.id,
      //   title: ad.title,
      //   dateCreated: ad.dateCreated,
      //   description: description,
      //   type: type,
      //   location: ad.location,
      // ),
      // );

      AdvertModel ad = adverts[adPos];
      adverts[adPos] = AdvertModel(
        id: ad.id,
        userId: ad.userId,
        title: title ?? ad.title,
        dateCreated: ad.dateCreated,
        description: description ?? ad.description,
        type: type ?? ad.type,
        domain: domain ?? ad.domain,
      );

      return state.copy(
        activeAd: adverts[adPos],
        adverts: adverts,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  void before() => dispatch(WaitAction.add("edit_advert"));

  @override
  void after() async {
    dispatch(NavigateAction.pop());
    dispatch(WaitAction.remove("edit_advert"));
  }

  // sends error messages to CustomWrapError
  @override
  Object wrapError(error) {
    return error;
  }
}

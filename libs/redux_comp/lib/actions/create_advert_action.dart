import 'package:amplify/models/Advert.dart';
import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../app_state.dart';
import '../models/advert_model.dart';

class CreateAdvertAction extends ReduxAction<AppState> {
  final String id;
  final Advert advert;

  CreateAdvertAction(this.id, this.advert);

  @override
  Future<AppState?> reduce() async {
    try {
      Advert ad = Advert(consumerID: id, title: advert.title, description: advert.description);
      final request = ModelMutations.create(ad);
      final response = await Amplify.API.mutate(request: request).response;
      
      Advert? createdAd = response.data;
      if (createdAd == null) return state; //in future set warning in app state

      List<Advert> ads = [createdAd] + state.adverts;
      return state.replace(adverts: ads);
      // exception will be handled later
    } catch (e) {
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }
}

import 'dart:async';
import 'package:amplify/models/Advert.dart';
import 'package:amplify/models/Consumer.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/app_state.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      final requestID = ModelQueries.list(Consumer.classType,
          where: Consumer.EMAIL.contains(email));

      final responseID = await Amplify.API.query(request: requestID).response;
      
        String id = responseID.data!.items[0]!.id;
        String? username = responseID.data!.items[0]!.email;
      
      final requestAdverts = ModelQueries.list(Advert.classType,
          where: Advert.CONSUMERID.contains(id));

      final responseAdverts = await Amplify.API.query(request: requestAdverts).response;
    
      List<Advert>? consumerAdverts = [];

      for (Advert? advert in responseAdverts.data!.items) {
        consumerAdverts.add(advert!);
      }
      
      return state.replace(
        id: id, 
        username: username,
        adverts: consumerAdverts
        );
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

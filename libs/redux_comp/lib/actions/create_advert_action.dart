import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/job_type.dart';
import 'package:uuid/uuid.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

// creates an advert
// requires the customerdId and a title the rest is optional
class CreateAdvertAction extends ReduxAction<AppState> {
  final String customerId;
  final String title;
  final String? description;
  final JobType? type;
  final String? location;

  CreateAdvertAction(
    this.customerId,
    this.title, {
    this.description,
    this.type,
    this.location,
  }); // Create...(id, title, description: desc)

  @override
  Future<AppState?> reduce() async {
    String adId = "a#${const Uuid().v1()}";

    // type is not used currently but will be implemented in the future
    String graphQLDocument = '''mutation {
      createAdvert(customer_id: "$customerId", ad_id: "$adId", title: "$title", description: "$description", location: "$location") {
        id
        user_id
        price_lower
        price_upper
        quote
        date_created
        date_closed
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      final response = await Amplify.API.mutate(request: request).response;

      List<AdvertModel> adverts = state.user!.adverts;
      adverts.add(AdvertModel(
          id: customerId,
          title: title,
          dateCreated: response.data['createAdvert'][0]['advert_details']
              ['date_created']));

      return state.replace(user: state.user!.replace(adverts: adverts));
    } catch (e) {
      return state;
    }
  }
}

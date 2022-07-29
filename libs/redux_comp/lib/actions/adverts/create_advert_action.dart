import 'package:amplify_api/amplify_api.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';

// creates an advert
// requires the customerdId and a title the rest is optional
class CreateAdvertAction extends ReduxAction<AppState> {
  final String customerId;
  final String title;
  final String? description;
  final String type;
  final String location;

  CreateAdvertAction(
    this.customerId,
    this.title,
    this.location,
    this.type, {
    this.description,
  }); // Create...(id, title, description: desc)

  @override
  Future<AppState?> reduce() async {
    String adId = "a#${const Uuid().v1()}";

    // type is not used currently but will be implemented in the future
    String graphQLDocument = '''mutation {
      createAdvert(customer_id: "$customerId", ad_id: "$adId", title: "$title", description: "$description", location: "$location", type: "$type") {
        id
        date_created
        location
        title
        type
        description
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      /* final response = */ await Amplify.API
          .mutate(request: request)
          .response;

      // List<AdvertModel> adverts = state.adverts;
      // final data = jsonDecode(response.data);
      // adverts.add(AdvertModel(
      //     id: customerId,
      //     title: title,
      //     dateCreated: data['createAdvert']['date_created'],
      //     location: 'temp location'));

      return null;
    } catch (e) {
      return null; // on error does not modify appstate
    }
  }

  @override
  void before() => dispatch(WaitAction.add("create_advert"));

  @override
  void after() async {
    dispatch(ViewAdvertsAction());
    dispatch(NavigateAction.pushNamed("/consumer"));
    dispatch(WaitAction.remove("create_advert"));
  }
}

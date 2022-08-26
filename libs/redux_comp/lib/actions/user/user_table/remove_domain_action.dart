import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import '../../../models/geolocation/domain_model.dart';

/* Remove domain from a user */
/* requires the city as well as the suer ID */

class RemoveDomainAction extends ReduxAction<AppState> {
  final String city;

  RemoveDomainAction(this.city);

  @override
  Future<AppState?> reduce() async {
    List<Domain> domains = List.from(state.userDetails!.domains);
    domains.removeWhere((element) => element.city == city);

    return state.copy(userDetails: state.userDetails!.copy(domains: domains));
  }
}

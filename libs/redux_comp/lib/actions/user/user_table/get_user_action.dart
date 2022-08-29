import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/actions/adverts/view_jobs_action.dart';
import 'package:redux_comp/actions/chat/subscribe_messages_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

/* GetUserAction */
/* This action fetches a user of a specified group and populates the user model with the results */

class GetUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // request different info for different user type
    if (state.userDetails!.userType == "Consumer") {
      final String id = state.userDetails!.id;
      String graphQLDoc = '''query  {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          location {
            address {
              streetNumber
              street
              city
              province
              zipCode
            }
            coordinates {
              lat
              lng
            }
          }
        }
      }
      ''';

      final request = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final data = jsonDecode(
            (await Amplify.API.query(request: request).response).data);
        final user = data["viewUser"];
        // build place model from result
        Location location = Location.fromJson(user["location"]);

        return state.copy(
          userDetails: state.userDetails!.copy(
            name: user["name"],
            cellNo: user["cellNo"],
            email: user["email"],
            location: location,
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else if (state.userDetails!.userType == "Tradesman") {
      final String id = state.userDetails!.id;
      String graphQLDoc = '''query {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          domains {
            city
            province
            coordinates {
              lat
              lng
            }
          }
          tradetypes
        }
      }
      ''';

      final request = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final data = jsonDecode(
            (await Amplify.API.query(request: request).response).data);
        final user = data["viewUser"];

        List<Domain> domains = [];
        for (dynamic domain in user["domains"]) {
          domains.add(Domain.fromJson(domain));
        }
        List<String> tradeTypes = [];
        for (dynamic trade in user["tradetypes"]) {
          tradeTypes.add(trade);
        }

        return state.copy(
          userDetails: state.userDetails!.copy(
            name: user["name"],
            email: user["email"],
            cellNo: user["cellNo"],
            domains: domains,
            tradeTypes: tradeTypes,
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else if (state.userDetails!.userType == "Admin") {
      final String id = state.userDetails!.id;
      String graphQLDoc = '''query {
        viewUser(user_id: "$id") {
          id
          email
          name
          scope
        }
      }
      ''';

      final request = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        final data = jsonDecode(
            (await Amplify.API.query(request: request).response).data);
        final user = data["viewUser"];
        return state.copy(
          userDetails: state.userDetails!.copy(
            name: user["name"],
            email: user["email"],
            scope: user["scope"]
          )
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  void after() async {
    switch (state.userDetails!.userType) {
      case "Consumer":
        dispatch(ViewAdvertsAction());
        dispatch(SubscribMessagesAction());
        dispatch(NavigateAction.pushNamed("/consumer"));
        break;
      case "Tradesman":
        List<String> domains = [];
        for (Domain d in state.userDetails!.domains) {
          domains.add(d.city);
        }
        List<String> tradeTypes = state.userDetails!.tradeTypes;
        dispatch(ViewJobsAction(domains, tradeTypes));
        dispatch(SubscribMessagesAction());
        dispatch(NavigateAction.pushNamed("/tradesman"));
        break;
      case "Admin":
        dispatch(NavigateAction.pushNamed("/admin_metrics"));
        break;
    }
    // wait until error has finished before stopping loading
    store.waitCondition((state) => state.error == ErrorType.none);
    dispatch(WaitAction.remove("flag"));
    dispatch(WaitAction.remove("auto-login"));
  }
}

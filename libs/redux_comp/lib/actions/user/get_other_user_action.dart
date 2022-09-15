import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/get_profile_photo_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/geolocation/domain_model.dart';
import '../../models/geolocation/location_model.dart';
import '../../models/user_models/statistics_model.dart';

// gets all details of another user to view their profile page as well as moves to the profile page

class GetOtherUserAction extends ReduxAction<AppState> {
  final String userId;

  GetOtherUserAction(this.userId);

  @override
  Future<AppState?> reduce() async {
    // getting profile image
    dispatch(GetProfilePhotoAction(userId: userId));

    final String userType =
        userId.substring(0, 2) == 'c#' ? 'Consumer' : 'Tradesman';

    final String id = userId;

    if (userType == "Consumer") {
      String graphQLDoc = '''query  {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          created
          finished
          rating_sum
          rating_count
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

        final StatisticsModel userStatistics = StatisticsModel.fromJson(user);

        return state.copy(
          otherUserDetails: state.otherUserDetails.copy(
            name: user["name"],
            cellNo: user["cellNo"],
            email: user["email"],
            location: location,
            statistics: userStatistics,
            userType: userType,
            id: userId,
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      String graphQLDoc = '''query {
        viewUser(user_id: "$id") {
          id
          email
          name
          cellNo
          created
          finished
          rating_sum
          rating_count
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

        final StatisticsModel userStatistics = StatisticsModel.fromJson(user);

        return state.copy(
          otherUserDetails: state.otherUserDetails.copy(
            name: user["name"],
            email: user["email"],
            cellNo: user["cellNo"],
            domains: domains,
            tradeTypes: tradeTypes,
            statistics: userStatistics,
            userType: userType,
            id: userId,
          ),
        );
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    }
  }

  @override
  void before() => dispatch(
        NavigateAction.pushNamed('/tradesman/limited_tradesman_profile_page'),
      );
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:redux_comp/models/error_type_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

/* If this code seems unique from the rest in this project, that's cause it is */
/* Refreshes the user session so we can see the updates to the user groups which is stored in the AccessToken */
/*
  Hopefully someday we can do something like

    Amplify.Auth.refreshSession();

      ... that day is not today

*/

class RefreshUserTokenAction extends ReduxAction<AppState> {
  String refreshToken = "";
  final client = http.Client();

  RefreshUserTokenAction(this.refreshToken);

  @override
  Future<AppState?> reduce() async {
    if (refreshToken.isNotEmpty) {
      final reqBody = {
        "ClientId": "5sjgir76gfiuar2iu2t6v4ml5a",
        "AuthFlow": 'REFRESH_TOKEN_AUTH',
        "AuthParameters": {
          "REFRESH_TOKEN": refreshToken,
        }
      };
      try {
        final http.Response resp = await http.post(
          Uri.parse('https://cognito-idp.eu-west-1.amazonaws.com/'),
          headers: <String, String>{
            "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
            "Content-Type": "application/x-amz-json-1.1",
          },
          body: jsonEncode(reqBody),
        );

        final respBody = jsonDecode(resp.body);
        final accessToken = respBody["AuthenticationResult"]!["AccessToken"];

        Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

        List<String> groups = List<String>.from(payload["cognito:groups"]);

        String userType = "";
        if (state.userDetails.userType == "") {
          if (groups.contains("customer")) {
            userType = "Consumer";
          } else if (groups.contains("tradesman")) {
            userType = "Tradesman";
          } else {
            return state.copy(error: ErrorType.userNotInGroup);
          }
        } else {
          return state.copy(error: ErrorType.failedToReadGroup);
        }

        return state.copy(
          userDetails: state.userDetails.copy(userType: userType),
          authModel: state.authModel!.copy(accessToken: accessToken),
          error: ErrorType.none,
        );
      } catch (e) {
        debugPrint("Error in Cognito API call in actions/user/refresh_token");
        return state.copy(error: ErrorType.failedToRefreshToken);
      }
    } else {
      return state.copy(error: ErrorType.failedToRefreshToken);
    }
  }
}

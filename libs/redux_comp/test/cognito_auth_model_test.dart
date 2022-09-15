import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/user_models/cognito_auth_model.dart';

void main() {
  CognitoAuthModel modelOne = const CognitoAuthModel(
      accessToken: "accessTokenOne", refreshToken: "refreshTokenOne");

  CognitoAuthModel copy = modelOne.copy(accessToken: "accessTokenTwo");

  test("Unit Testing Copy Method of  CognitoAuthModel", () {
    expect("accessTokenTwo", copy.accessToken);
    expect("refreshTokenOne", copy.refreshToken);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
// import 'package:redux_comp/app_state.dart';
// import 'package:redux_comp/models/user_models/consumer_model.dart';

void main() {
  test("Mock Test Redux", () {
    expect(true, true);
  });

  PartialUser partUser = const PartialUser(
    email: 'someone@example.com',
    group: "test",
    verified: 'CONFIRM_SIGN_UP_STEP',
  );

  test('Test to get PartialUser Email', () {
    expect('someone@example.com', partUser.email);
  });

  test('Test to get PartialUser Group', () {
    expect('test', partUser.group);
  });

  test('Test to get PartialUser Verification Step', () {
    expect('CONFIRM_SIGN_UP_STEP', partUser.verified);
  });

  test('Test to get PartialUser copy Method', () {
    expect(partUser.copy(verified: 'DONE').verified, 'DONE');
  });

  UserModel user = const UserModel(
    id: '001',
    email: 'some@example.com',
    name: 'someone',
    cellNo: '0821234567',
    userType: 'Consumer',
    externalProvider: false,
    registered: true,
    externalUsername: "test1234",
    scope: "global",
  );

  test('Test to get UserId', () {
    expect('001', user.id);
  });

  test('Test to get User Email', () {
    expect('some@example.com', user.email);
  });

  test('Test to get UserType', () {
    expect('Consumer', user.userType);
  });

  UserModel copy = user.copy();

  test("Testing copy method of UserModel", () {
    expect(user.id, copy.id);
    expect(user.email, copy.email);
    expect(user.name, copy.name);
    expect(user.cellNo, copy.cellNo);
    expect(user.userType, copy.userType);
    expect(user.externalProvider, copy.externalProvider);
    expect(user.registered, copy.registered);
    expect(user.externalUsername, copy.externalUsername);
    expect(copy.scope, user.scope);
  });
}

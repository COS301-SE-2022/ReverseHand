import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
// import 'package:redux_comp/app_state.dart';
// import 'package:redux_comp/models/user_models/consumer_model.dart';

void main() {
  test("Mock Test Redux", () {
    expect(true, true);
  });

  PartialUser partUser = const PartialUser(
      'someone@example.com', 'password', 'CONFIRM_SIGN_UP_STEP');

  test('Test to get PartialUser Email', () {
    expect('someone@example.com', partUser.email);
  });

  test('Test to get PartialUser Password', () {
    expect('password', partUser.password);
  });

  test('Test to get PartialUser Verification Step', () {
    expect('CONFIRM_SIGN_UP_STEP', partUser.verified);
  });

  test('Test to get PartialUser Replace Method', () {
    expect(partUser.replace(verified: 'DONE').verified, 'DONE');
  });

  UserModel user = const UserModel(
      id: '001',
      email: 'some@example.com',
      name: 'someone',
      userType: 'Consumer',
      bids: [],
      shortlistBids: [],
      viewBids: [],
      adverts: []);

  test('Test to get UserId', () {
    expect('001', user.id);
  });

  test('Test to get User Email', () {
    expect('some@example.com', user.email);
  });

  test('Test to get UserType', () {
    expect('Consumer', user.userType);
  });

  test('Test to get UserAdverts', () {
    expect([], user.adverts);
  });

  AdvertModel ad =
      const AdvertModel(id: "a#001", title: "TestAd", dateCreated: 'today');

  test('Test to add UserAdvert', () {
    expect([ad], user.replace(adverts: [ad]).adverts);
  });
}

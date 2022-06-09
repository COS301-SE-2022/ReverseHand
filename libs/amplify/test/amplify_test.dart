import 'package:amplify/amplify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mock Test: Amplify', () {
    expect(true, true);
  });

  User user = User(id: "123", name: "Test Model", email: "test@gmail.com");
  User user1 = User(id: "123", name: "Test Model", email: "test@gmail.com");
  User user2 = User(id: "1234", name: "Test Model", email: "test@gmail.com");
  test("Test the get id method", () {
    expect("123", user.getId());
  });

  test("Testing the email", () {
    expect("test@gmail.com", user.email);
  });

  test("Testing the name", () {
    expect("Test Model", user.name);
  });

  test("testing the equality", () {
    expect(true, user.equals(user1));
  });

  test("Testing the  == ", () {
    expect(false, user1 == user2);
  });

  test("Testing == ", () {
    expect(true, user == user1);
  });
}

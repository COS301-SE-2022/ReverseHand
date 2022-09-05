import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

void main() {
  ReportedUserModel user1 = const ReportedUserModel(
      id: "id", email: "emailTest", name: "Test name", cellNo: "123456789");

  ReportedUserModel userOneCopy = user1.copy();
  ReportedUserModel userTwoCopy = user1.copy(id: "idOne");

  test("Testing copy method of ReportedUserModel", () {
    expect(userOneCopy.id, user1.id);
    expect(userOneCopy.email, user1.email);
    expect(userOneCopy.name, user1.name);
    expect(userOneCopy.cellNo, user1.cellNo);

    expect(userTwoCopy.id, "idOne");
    expect(userTwoCopy.email, user1.email);
    expect(userTwoCopy.name, user1.name);
    expect(userTwoCopy.cellNo, user1.cellNo);
  });
}

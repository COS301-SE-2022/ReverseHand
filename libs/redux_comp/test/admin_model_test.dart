import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/admin/admin_model.dart';
import 'package:redux_comp/models/admin/advert_report_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

void main() {
  ReportedUserModel r1 = const ReportedUserModel(
      id: "id", email: "email", name: "name", cellNo: "cellNo");

  ReportedUserModel r2 = const ReportedUserModel(
      id: "id2", email: "email2", name: "name2", cellNo: "cellNo2");

  List<ReportedUserModel> reportedCustomers = [];
  reportedCustomers.add(r1);
  reportedCustomers.add(r2);

  ReportedUserModel activeUser = const ReportedUserModel(
      id: "id3", email: "email3", name: "name3", cellNo: "cellNo3");

  Domain domain = const Domain(
      city: "city",
      province: "province",
      coordinates: Coordinates(lat: 22, lng: 22));
  List<AdvertReportModel> reports = [];

  ReportedAdvertModel r3 = ReportedAdvertModel(
      id: "id4",
      count: 33,
      customerId: "customerId",
      advert: AdvertModel(
          id: "id", title: "title", domain: domain, dateCreated: 9875),
      reports: reports);

  List<ReportedAdvertModel> activeAdverts = [];
  activeAdverts.add(r3);

  AdminModel original = AdminModel(
      reportedCustomers: reportedCustomers,
      activeUser: activeUser,
      activeAdverts: activeAdverts);

  AdminModel ogCopy = original.copy();

  test("Testing copy method AdminModel", () {
    expect(ogCopy.reportedCustomers, original.reportedCustomers);
    expect(ogCopy.activeUser, original.activeUser);
    expect(ogCopy.activeAdverts, original.activeAdverts);
  });
}

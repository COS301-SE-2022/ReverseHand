import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/pages/activity_stream_page.dart';
import 'package:tradesman/pages/domain_confirmation_page.dart';
import 'package:tradesman/pages/tradesman_profile_page.dart';
import 'package:tradesman/tradesman.dart';
import 'package:tradesman/widgets/notification_card_widget.dart';

void main() {
  testWidgets("Test Tradesnan  Listings", (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());
    //spin up the widget
    await tester.pumpWidget(TradesmanJobListings(store: store));

    //App Bar stuff
    var title = find.widgetWithText(AppBarWidget, "JOB LISTINGS");
    expect(title, findsOneWidget);

    var icon = find.widgetWithIcon(AppBarWidget, Icons.notifications);
    expect(icon, findsOneWidget);
  });

  testWidgets("Tradesman Profile", (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());
    await tester.pumpWidget(TradesmanProfilePage(store: store));

    //App bar stuff
    var profile = find.widgetWithText(AppBarWidget, "PROFILE");
    expect(profile, findsOneWidget);

    var accountCircle = find.byIcon(Icons.account_circle);
    expect(accountCircle, findsOneWidget);

    var mail = find.byIcon(Icons.email);
    expect(mail, findsOneWidget);

    var mailText = find.text("Email");
    expect(mailText, findsOneWidget);

    var phoneIcon = find.byIcon(Icons.phone);
    expect(phoneIcon, findsOneWidget);

    var phoneText = find.text("Phone");
    expect(phoneText, findsOneWidget);

    var constructionIcon = find.byIcon(Icons.construction_outlined);
    expect(constructionIcon, findsOneWidget);

    var tradeText = find.text("Trade");
    expect(tradeText, findsOneWidget);

    var domainText = find.text("Domains");
    expect(domainText, findsOneWidget);

    var locationIcon = find.byIcon(Icons.location_on);
    expect(locationIcon, findsOneWidget);

    var editButton = find.byIcon(Icons.edit);
    expect(editButton, findsOneWidget);

    //Nav bar
    var workIcon = find.byIcon(Icons.work);
    expect(workIcon, findsOneWidget);

    var forumIcon = find.byIcon(Icons.forum);
    expect(forumIcon, findsOneWidget);

    var personIcon = find.byIcon(Icons.person);
    expect(personIcon, findsOneWidget);

    var logoutIcon = find.byIcon(Icons.logout);
    expect(logoutIcon, findsOneWidget);
  });

  testWidgets("activity stream page", (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());
    await tester.pumpWidget(ActivityStream(store: store));

    var jobInfo = find.widgetWithText(AppBarWidget, "ACTIVITY STREAM");
    expect(jobInfo, findsOneWidget);

    var titleText = find.widgetWithText(NotificationCardWidget, "Accepted!");
    expect(titleText, findsOneWidget);

    var submittedText =
        find.widgetWithText(NotificationCardWidget, "Shortlisted!");
    expect(submittedText, findsOneWidget);

    var bidSubmittedText =
        find.widgetWithText(NotificationCardWidget, "Bid Submitted!");
    expect(bidSubmittedText, findsOneWidget);
  });

  testWidgets("Advert Details Page", (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());
    await tester.pumpWidget(DomainConfirmPage(store: store));

    var title = find.widgetWithText(AppBarWidget, "DOMAINS DISPLAY");
    expect(title, findsOneWidget);

    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);
  });
}

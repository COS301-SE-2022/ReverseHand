import 'package:admin/pages/admin_profile_page.dart';
import 'package:admin/pages/app_management/advert_reports/review_advert_reports_page.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:authentication/pages/usertype_selection_page.dart';
import 'package:consumer/pages/edit_profile_page.dart';
import 'package:consumer/pages/limited_consumer_profile_page.dart';
import 'package:consumer/pages/view_quote_page.dart';
import 'package:general/general.dart';
import 'package:general/pages/archived_jobs_page.dart';
import 'package:general/pages/archived_advert_details_page.dart';
import 'package:general/pages/archived_bid_details_page.dart';
import 'package:general/pages/archived_view_bids_page.dart';
import 'package:general/pages/report_page.dart';
import 'package:general/methods/toast_error.dart';
import 'package:geolocation/pages/custom_location_search_page.dart';
import 'package:geolocation/pages/location_confirm_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/chat_selection_page.dart';
import 'package:consumer/consumer.dart';
import 'package:consumer/pages/advert_details_page.dart';
import 'package:consumer/pages/bid_details_page.dart';
import 'package:consumer/pages/consumer_profile_page.dart';
import 'package:consumer/pages/edit_advert_page.dart';
import 'package:consumer/pages/view_bids_page.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/pages/bid_details_page.dart';
import 'package:tradesman/pages/domain_confirmation_page.dart';
import 'package:tradesman/pages/edit_bid_page.dart';
import 'package:tradesman/pages/edit_profile_page.dart';
import 'package:tradesman/pages/limited_tradesman_profile_page.dart';
import 'package:tradesman/pages/reviews_page.dart';
import 'package:tradesman/pages/tradesman_profile_page.dart';
import 'package:tradesman/pages/view_bids_page.dart';
import 'package:tradesman/tradesman.dart';
import 'package:admin/admin.dart';
import 'package:general/pages/activity_stream.dart';
import 'package:redux_comp/custom_wrap_error.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  NavigateAction.setNavigatorKey(navigatorKey);

  // acts as main function
  runApp(
    Launch(
      store: Store<AppState>(
        initialState: AppState.initial(),
        wrapError: CustomWrapError(),
      ),
    ),
  );
}

class Launch extends StatelessWidget {
  final Store<AppState> store;

  const Launch({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: UserExceptionDialog<AppState>(
          onShowUserExceptionDialog: (BuildContext context,
                  UserException userException, bool useLocalContext) =>
              displayToastError(
            context,
            userException.msg!,
          ),
          child: LoginPage(store: store),
        ),
        // initialRoute: '/',
        navigatorKey: navigatorKey,
        // defining what routes look like
        routes: {
          // '/': (context) => LoginPage(store: store),
          // consumer routes
          '/consumer': (context) => ConsumerListingsPage(store: store),
          '/consumer/create_advert': (context) =>
              CreateNewAdvertPage(store: store),
          '/consumer/advert_details': (context) =>
              AdvertDetailsPage(store: store),
          '/consumer/advert_details/bid_details': (context) =>
              BidDetailsPage(store: store),
          '/consumer/consumer_profile_page': (context) =>
              ConsumerProfilePage(store: store),
          '/consumer/view_bids': (context) => ViewBidsPage(store: store),
          '/consumer/edit_advert_page': (context) =>
              EditAdvertPage(store: store),
          '/consumer/edit_profile_page': (context) =>
              EditConsumerProfilePage(store: store),
          '/consumer/limited_profile_page': (context) =>
              LimitedConsumerProfilePage(store: store),
          '/consumer/view_quote_page': (context) => ViewQuotePage(store: store),
          // tradesman routes
          '/tradesman': (context) => TradesmanJobListings(store: store),
          '/tradesman/advert_details': (context) =>
              TradesmanJobDetails(store: store),
          '/tradesman/profile': (context) => TradesmanProfilePage(store: store),
          '/tradesman/view_bids_page': (context) =>
              TradesmanViewBidsPage(store: store),
          '/tradesman/advert_details/bid_details': (context) =>
              TBidDetailsPage(store: store),
          '/tradesman/edit_bid': (context) => TEditBidPage(store: store),
          '/geolocation/location_confirm': (context) =>
              LocationConfirmPage(store: store),
          '/geolocation/custom_location_search': (context) =>
              CustomLocationSearchPage(store: store),
          '/tradesman/domain_confirm': (context) =>
              DomainConfirmPage(store: store),
          '/tradesman/view_bids': (context) =>
              TradesmanViewBidsPage(store: store),
          '/tradesman/reviews': (context) =>
              ReviewsPage(store: store),
          '/tradesman/edit_profile_page': (context) =>
              EditTradesmanProfilePage(store: store),
          '/tradesman/limited_tradesman_profile_page': (context) =>
              LimitedTradesmanProfilePage(store: store),
          // shared routes for consumer and tradesman
          '/general/activity_stream': (context) =>
              ActivityStreamPage(store: store),
          '/general/report_page': (context) => ReportPage(
                store: store,
              ),
          // authentication routes
          '/signup': (context) => SignUpPage(store: store),
          '/usertype_selection': (context) =>
              UserTypeSelectionPage(store: store),
          '/login': (context) => LoginPage(store: store),
          '/chats': (context) => ChatSelectionPage(store: store),
          '/chats/chat': (context) => ChatPage(store: store),
          '/archived_jobs': (context) => ArchivedJobsPage(store: store),
          '/archived_advert_details/archived_bid_details': (context) =>
              ArchivedBidDetailsPage(store: store),
          '/archived_advert_details': (context) =>
              ArchivedAdvertDetailsPage(store: store),
          '/archived_view_bids': (context) =>
              ArchivedViewBidsPage(store: store),
          //admin routes
          '/admin_system_metrics': (context) => SystemMetricsPage(store: store),
          '/admin_management': (context) => AdminManagePage(store: store),
          '/search_users': (context) => SearchUsersPage(store: store),
          '/user_reports_page': (context) => ViewUserReportsPage(store: store),
          '/review_reports_page': (context) =>
              ViewReviewReportsPage(store: store),
          '/advert_reports_page': (context) =>
              ViewAdvertReportsPage(store: store),
          '/report_manage': (context) => ReportManagePage(store: store),
          '/review_report_manage': (context) =>
              ReviewReportManagePage(store: store),
          '/user_manage': (context) => UserManagePage(store: store),
          '/database_metrics': (context) => DatabaseMetricsPage(store: store),
          '/api_metrics': (context) => ApiMetricsPage(store: store),
          '/resolver_metrics': (context) => ResolverMetricsPage(store: store),
          '/review_advert_reports_page': (context) =>
              AdvertReportsManagePage(store: store),
          '/admin_profile': (context) => AdminProfilePage(store: store),
          '/user_metrics': (context) => UserMetricsPage(store: store),
          '/admin/sentiment': (context) => SentimentAnalysisPage(store: store),
          '/admin/custom_metrics': (context) => CustomMetricsPage(store: store)
        },
      ),
    );
  }
}

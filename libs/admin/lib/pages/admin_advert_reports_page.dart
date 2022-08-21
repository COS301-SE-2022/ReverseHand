import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_reported_advert_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminAdvertReportsPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminAdvertReportsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                List<Widget> reportedAds = [];
                for (ReportedAdvertModel ad in vm.reportedAds) {
                  reportedAds.add(QuickViewReportedAdvertCardWidget(
                      advert: ad, store: store));
                }

                return Column(
                  children: [
                    //*******************APP BAR WIDGET*********************//
                    AppBarWidget(
                        title: "Advert Reports for ${vm.activeUser.name}",
                        store: store),
                    //********************************************************//

                    //if there are adverts, heading should be displayed
                    if (vm.reportedAds.isNotEmpty)
                      Column(
                        children: [...reportedAds],
                      ),
                  ],
                );
              }),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminAdvertReportsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        reportedAds: (state.admin.activeAdverts == null)
            ? []
            : state.admin.activeAdverts!,
        activeUser: state.admin.activeUser!,
      );
}

// view model
class _ViewModel extends Vm {
  // final void Function(String) dispatchViewBidsAction;
  final List<ReportedAdvertModel> reportedAds;
  final ReportedUserModel activeUser;

  _ViewModel({
    required this.reportedAds,
    required this.activeUser,
  }) : super(equals: [reportedAds, activeUser]);
}

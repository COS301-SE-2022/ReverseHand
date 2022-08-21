import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_reported_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminAdvertReports extends StatelessWidget {
  final Store<AppState> store;
  const AdminAdvertReports({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> reportedUsers = [];
              for (ReportedUserModel user in vm.reportedCustomers) {
                reportedUsers.add(QuickViewReportedUserCardWidget(user: user, store: store));
              }

              return Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  AppBarWidget(title: "Customer Reports", store: store),
                  //********************************************************//

                  //if there are adverts, heading should be displayed
                  if (vm.reportedCustomers.isNotEmpty) 
                    Column(
                      children: [...reportedUsers],
                    ),
                ],
              );
            }
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}


// factory for view model
class _Factory extends VmFactory<AppState, AdminAdvertReports> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        reportedCustomers: state.admin.reportedCustomers,
      );
}

// view model
class _ViewModel extends Vm {
  // final void Function(String) dispatchViewBidsAction;
  final List<ReportedUserModel> reportedCustomers;

  _ViewModel({
    required this.reportedCustomers,
  }) : super (equals: [reportedCustomers]);
}

import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_reported_advert_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminContentPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminContentPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> reportedAdverts = [];
              if (vm.adverts != null) {
                for (ReportedAdvertModel advert in vm.adverts!) {
                  reportedAdverts.add(QuickViewReportedAdvertCardWidget(
                      advert: advert, store: store));
                }
              }
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        AppBarWidget(title: "Reported Adverts", store: store),
                        //*******************************************//

                        LoadingWidget(
                            padding: MediaQuery.of(context).size.height / 3)
                      ],
                    )
                  : 
                  Column(
                      children: [
                        //**********APPBAR***********//
                        AppBarWidget(title: "Reported Adverts", store: store),
                        ...reportedAdverts,
                        Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonWidget(
                              text: "View all adverts",
                              function: () {},
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminContentPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        adverts: state.admin.activeAdverts,
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<ReportedAdvertModel>? adverts;

  _ViewModel({
    required this.loading,
    required this.adverts,
  }) : super(equals: [loading, adverts]);
}

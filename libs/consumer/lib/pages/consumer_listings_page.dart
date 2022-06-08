import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

import 'create_new_job.dart';
import 'job_details.dart';

class ConsumerListingsPage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListingsPage({Key? key, required this.store}) : super(key: key);

  Column populateAdverts(List<AdvertModel> adverts, BuildContext context) {
    List<Widget> quickViewJobCardWidgets = [];
    double height = (MediaQuery.of(context).size.height) / 3;

    //*******************PADDING FOR THE TOP*******************//
    quickViewJobCardWidgets
        .add(const Padding(padding: EdgeInsets.only(top: 20)));
    //*********************************************************//

    //*******QUICK VIEW AD WIDGETS - TAKES YOU TO DETAILED JOB VIEW ON CLICK********//
    for (AdvertModel advert in adverts) {
      quickViewJobCardWidgets.add(QuickViewJobCardWidget(
        titleText: advert.title,
        date: advert.dateCreated,
        onTap: () {
          store.dispatch(ViewBidsAction(advert.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConsumerDetails(
                store: store,
                advert: advert,
              ),
            ),
          );
        },
      ));
    }
    //****************************************************************************//

    //********BUTTON TO CREATE A NEW JOB - TAKES YOU TO CREATE_NEW_JOB ON CLICK********//
    quickViewJobCardWidgets.add(
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.all(height / 3),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
              shadowColor: Colors.black,
              elevation: 9,
              textStyle: const TextStyle(fontSize: 30),
              minimumSize: const Size(60, 60),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CreateNewJob(store: store)));
            },
            child: const Text("+"), //Look into an icon for demo 3
          ),
        ),
      ),
    );
    //*******************************************************************************//

    return Column(children: quickViewJobCardWidgets);
  }

  //*****Calls method display all active jobs made by a consumer*****//
  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height) / 3;

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(height / 3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 9,
                          textStyle: const TextStyle(fontSize: 30),
                          minimumSize: const Size(60, 60),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                        onPressed: () => vm.pushCreateAdvertPage(),
                        child: const Text("+"), //Look into an icon for demo 3
                      ),
                    ),
                  ),
                  StoreConnector<AppState, List<AdvertModel>>(
                    converter: (store) => store.state.user!.adverts,
                    builder: (context, adverts) {
                      return populateAdverts(adverts, context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ConsumerListingsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushCreateAdvertPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/create_advert'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateAdvertPage;

  _ViewModel({
    required this.pushCreateAdvertPage,
  }); // implementinf hashcode
}

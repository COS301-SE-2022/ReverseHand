import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/methods/populate_bids.dart';

import '../widgets/place_bid_popup.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //**********PADDING FROM TOP***********//
                  const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                  //**********BACK BUTTON***********//
                  BackButton(
                    color: Colors.white,
                    onPressed: () => vm.popPage(),
                  ),
                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),
                  //**********DIVIDER***********//
                  const DividerWidget(),
                  //**********HEADING***********//
                  const Text(
                    "Information",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  //**********PADDING***********//
                  const Padding(padding: EdgeInsets.all(15)),
                  //**********Consumer Information***********//
                  Column(
                    children: const <Widget>[
                      Text(
                        "Client name: Luke Skywalker",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Client cellphone: +27 89 076 2347",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Client email: consumer@gmail.com",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  //**********PADDING***********//
                  const Padding(padding: EdgeInsets.all(15)),
                  //**********Place Bid***********//
                  ButtonWidget(
                    function: () {
                      DialogHelper.display(
                        context,
                        const PlaceBidPopupWidget(),
                      ); //trigger Place Bid popup
                    },
                    text: 'Place Bid',
                  ),

                  ...populateBids(vm.bids)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobDetails> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        advert: state.user!.activeAd!,
        bids: state.user!.bids + state.user!.shortlistBids,
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;
  final List<BidModel> bids;

  _ViewModel({
    required this.advert,
    required this.bids,
    required this.popPage,
  }); // implementinf hashcode
}

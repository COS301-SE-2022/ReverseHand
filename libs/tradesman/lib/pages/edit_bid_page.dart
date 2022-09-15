import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/textfield.dart';

class TEditBidPage extends StatefulWidget {
  final Store<AppState> store;

  const TEditBidPage({Key? key, required this.store}) : super(key: key);

  @override
  State<TEditBidPage> createState() => TEditBidPageState();
}

class TEditBidPageState extends State<TEditBidPage> {
  RangeValues _currentRangeValues = const RangeValues(10, 3000);
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents floatingActionButton appearing above keyboard
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(children: [
              //*******************APP BAR WIDGET******************//
              AppBarWidget(title: "EDIT BID", store: widget.store),
              //***************************************************//

              //**********************SLIDER************************//
              //*****************Tradesman rates slider**********************
              const Text(
                "Choose bid price range:",
                style: TextStyle(fontSize: 15),
              ),
              RangeSlider(
                values: _currentRangeValues,
                max: 3000,
                divisions: 10,
                activeColor: Colors.orange,
                inactiveColor: Colors.black,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),

              //*****************************************************//
              //**************************************************//

              //********************DESCRIPTION**********************//
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 25),
                child: TextFieldWidget(
                  initialVal: "description",
                  label: "Phone",
                  obscure: false,
                  controller: descController,
                  min: 1,
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 30)),
              //**************************************************//

              //*******************SAVE BUTTON********************//
              //   //*******************SAVE BUTTON********************//
              ButtonWidget(
                  text: "Save Changes",
                  function: () {
                    // String? name, cellNo;
                    // (vm.userDetails.name != nameController.value.text) ? name = nameController.value.text : null;
                    // (vm.userDetails.cellNo != cellController.value.text) ? cellNo = cellController.value.text : null;
                    // vm.dispatchEditTradesmanAction(name, cellNo, vm.userDetails.domains);
                  }),
              //   //**************************************************//

              const Padding(padding: EdgeInsets.all(8)),
              ButtonWidget(
                  text: "Discard", color: "dark", function: vm.popPage),
            ]),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, TEditBidPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        bid: state.activeBid!,
        popPage: () => dispatch(NavigateAction.pop()),
        change: state.change,
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;
  final bool change;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.bid,
    required this.popPage,
    required this.change,
  }) : super(equals: [change]); // implementinf hashcode
}

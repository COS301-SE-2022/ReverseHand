import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/place_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';


class PlaceBidPopupWidget extends StatefulWidget {
  final Store<AppState> store;

   const PlaceBidPopupWidget({
    Key? key,
    required this.store
  }): super(key: key);

  @override
  State<PlaceBidPopupWidget> createState() => _PlaceBidPopupWidgetState();
}

class _PlaceBidPopupWidgetState extends State<PlaceBidPopupWidget> {
  RangeValues _currentRangeValues = const RangeValues(10, 3000);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState> (
      store: widget.store,
      child: Center(
        child: StoreConnector<AppState, _ViewModel>(
          vm:() => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Container(
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20)), 
                      onPressed: () {
                        vm.dispatchPlaceBidAction(vm.advert.id,vm.id,_currentRangeValues.start.round(),_currentRangeValues.end.round());
                        Navigator.pop(context);
                        },
                      child: const Text('X'),
                    ),
        
                  ),
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topCenter,
                  child: const Text(
                      "Place Bid",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const TransparentDividerWidget(),
        
                  //*****************Tradesman rates slider**********************
                  RangeSlider(
                    values: _currentRangeValues,
                    max: 3000,
                    divisions: 10,
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
                  const TransparentDividerWidget(),
                  //*****************************************************//
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }  
}

class _Factory extends VmFactory<AppState, _PlaceBidPopupWidgetState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        advert: state.user!.activeAd!,
        id: state.user!.id,
        dispatchPlaceBidAction:
            (String adId, String userId, int priceLower, int priceUpper) => dispatch(
              PlaceBidAction(adId, userId, priceLower, priceUpper)
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, int, int) dispatchPlaceBidAction;
  final AdvertModel advert;
  final String id;

  _ViewModel({
    required this.dispatchPlaceBidAction,
    required this.advert,
    required this.id,
  }); // implementinf hashcode
}



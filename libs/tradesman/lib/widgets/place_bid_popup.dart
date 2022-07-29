import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/place_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:general/widgets/textfield.dart';


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
    final descrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState> (
      store: widget.store,
      child: Center(
        child: StoreConnector<AppState, _ViewModel>(
          vm:() => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Container(
            height: 370,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(35, 47, 62, 0.97),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Center(
             child: SingleChildScrollView(
                child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topCenter,
                  child: const Text(
                      "Place Bid",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
        
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

                  //*****************Quote Description Box**********************
                  TextFieldWidget(
                    label: "Description",
                    obscure: false,
                    min: 3,
                    controller: descrController,
                    initialVal: null,
                  ),

                //*************************************************//
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vm.dispatchPlaceBidAction(vm.advert.id,vm.id,_currentRangeValues.start.round(),_currentRangeValues.end.round());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Background color
                      onPrimary: Colors.white, // Text Color (Foreground color)
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Colors.orange, width: 1),
                    )),
                    child: const Text('Submit'),
                  ),
                ],
              ),
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
        advert: state.activeAd!,
        id: state.userDetails!.id,
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



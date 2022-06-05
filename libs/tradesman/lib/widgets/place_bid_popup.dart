import 'package:authentication/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class PlaceBidPopupWidget extends StatelessWidget {
  
  const PlaceBidPopupWidget({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlaceBidPopUp(),
    );
  }

}

class PlaceBidPopUp extends StatefulWidget {
  PlaceBidPopUp({Key? key}) : super(key: key);
  final otpController = TextEditingController();

  void dispose() {
    otpController.dispose();
  }

  @override
  State<PlaceBidPopUp> createState() => PlaceBidPopUpState();
}

class PlaceBidPopUpState extends State<PlaceBidPopUp> {
  RangeValues _currentRangeValues = const RangeValues(10, 3000);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                  onPressed: () {},
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
              //*****************************************************

              //***************Verify Button *********************** */
              const ButtonWidget(
                //onPressed: Navigator.pop(context),
              ),
              //*****************************************************

            ],
          ),
        ),
      ),
    );
  }
  
}

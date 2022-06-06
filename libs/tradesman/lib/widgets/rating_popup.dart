import 'package:authentication/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:tradesman/widgets/rating_stars.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingPopUpWidget extends StatelessWidget {

  const RatingPopUpWidget({
    Key? key,
  }): super(key: key);

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RatingPopUp(),
    );
  }
}

class RatingPopUp extends StatefulWidget {
  RatingPopUp({Key? key}) : super(key: key);
  final otpController = TextEditingController();

  void dispose() {
    otpController.dispose();
  }

  @override
  State<RatingPopUp> createState() => RatingPopUpState();
}

class RatingPopUpState extends State<RatingPopUp> {
  double rating = 3.5;
  
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
                  "Rate Tradesman",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const TransparentDividerWidget(),

              //*****************rating stars**********************
              Align(
                alignment: Alignment.center,
                child: StarRating(
                  rating: rating,
                  onRatingChanged: (rating) => setState(() => this.rating = rating), color: Colors.orange,
                ),
              ),
              const TransparentDividerWidget(),
              //*****************************************************

              //***************Verify Button *********************** */
              // Eish when I pulled from dev this button no longer worked, 
              // I changed the constructor to take a string for the display text, and a function to use anonymously outside the widget
              // - Richard 
              //
              // const ButtonWidget(
              //   //onPressed: Navigator.pop(context),
              // ),
              //*****************************************************//

            ],
          ),
        ),
      ),
    );
  }
  
}



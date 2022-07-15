import 'package:flutter/material.dart';
import 'package:consumer/widgets/rating_stars.dart';
import 'package:general/widgets/button.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingPopUpWidget extends StatelessWidget {
  const RatingPopUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingPopUp();
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
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please rate the service you received",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            //*****************rating stars**********************
            StarRating(
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
              color: Colors.orange,
            ),
            //*****************************************************

            //********************BUTTONS*******************//
            ButtonWidget(text: "submit", function: () {}),

            //**********************************************//

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
    );
  }
}

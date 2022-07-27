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
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            const Text(
              "Please rate the service\n you received",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            //*****************rating stars**********************
            StarRating(
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
              color: Colors.orange,
            ),
            //*****************************************************
            const Padding(padding: EdgeInsets.all(25)),

            //********************BUTTONS*******************//
            ButtonWidget(text: "Submit", function: () {}),
            const Padding(padding: EdgeInsets.only(top: 5)),
            //**********************************************//
          ],
        ),
      ),
    );
  }
}

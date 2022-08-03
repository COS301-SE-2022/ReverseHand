import 'package:flutter/material.dart';
import 'package:consumer/widgets/rating_stars.dart';
import 'package:general/widgets/button.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingPopUpWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const RatingPopUpWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RatingPopUpWidget> createState() => RatingPopUpWidgetState();
}

class RatingPopUpWidgetState extends State<RatingPopUpWidget> {
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
              "Please rate the Contractor services\n you received.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            //*****************rating stars**********************
            StarRating(
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
              color: Colors.orange,
            ),
            //*****************************************************
            const Padding(padding: EdgeInsets.all(20)),

            //********************BUTTONS*******************//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: "Submit",
                  function: widget.onPressed, // fix later should pass in store
                ),
                const Padding(padding: EdgeInsets.all(5)),
                ButtonWidget(
                  text: "Cancel",
                  color: "light",
                  border: "lightBlue",
                  function: () => Navigator.pop(context),
                ),
              ],
            ),

            //**********************************************//
          ],
        ),
      ),
    );
  }
}

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
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              const Text(
                "Rate the services you received",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              //*****************rating stars**********************
              StarRating(
                rating: rating,
                onRatingChanged: (rating) =>
                    setState(() => this.rating = rating),
                color: Colors.orange,
              ),
              //*****************************************************
              const Padding(padding: EdgeInsets.all(20)),

              //***********************REVIEW*************************

              const Text(
                "Write a review",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              const SizedBox(
                width: 300,
                child: Text(
                    "An optional message to describe\n your experience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),

              const Padding(padding: EdgeInsets.all(10)),

              TextFormField(
                minLines: 4,
                maxLines: 9,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                obscureText: false,
                controller: reviewController,
                onTap: () {},
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              //*****************************************************

              const Padding(padding: EdgeInsets.all(20)),
              //********************BUTTONS*******************//
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    text: "Submit",
                    function:
                        widget.onPressed, // fix later should pass in store
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
      ),
    );
  }
}

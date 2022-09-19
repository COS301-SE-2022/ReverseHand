import 'package:flutter/material.dart';
import 'package:redux_comp/models/review_model.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewWidget({
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*****************STARS*****************//
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                //***************************************//

                //*****************REPORT****************//
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.report_outlined,
                        color: Theme.of(context).primaryColorDark,
                      )),
                ),
                //***************************************//
              ],
            ),
            //******************MESSAGE*****************//
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  '"${review.description}"',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            //***************************************//
          ],
        ),
      ),
    );
  }
}

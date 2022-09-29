import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/pages/report_page.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/review_model.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  final Store<AppState> store;
  final List<Icon> stars = [];

  ReviewWidget({
    required this.review,
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < review.rating; i++) {
      stars.add(
          Icon(Icons.star, size: 30, color: Theme.of(context).primaryColor));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 232, 232),
            borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*****************STARS*****************//
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(children: stars),
                ),
                //***************************************//

                //*****************REPORT****************//
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportPage(
                                    store: store,
                                    reportType: "Review",
                                    review: review,
                                  )
                                  
                            ),
                          );
                      },
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

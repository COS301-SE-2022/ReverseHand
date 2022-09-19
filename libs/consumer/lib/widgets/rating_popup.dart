import 'package:async_redux/async_redux.dart';
import 'package:consumer/controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:consumer/widgets/rating_stars.dart';
import 'package:general/methods/toast_error.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/user/reviews/add_review_action.dart';
import 'package:redux_comp/app_state.dart';

typedef RatingChangeCallback = void Function(double rating);

// class RatingPopUpWidget extends StatefulWidget {
// final VoidCallback onPressed;

// const RatingPopUpWidget({
//   Key? key,
//   required this.onPressed,
// }) : super(key: key);

//   @override
//   State<RatingPopUpWidget> createState() => RatingPopUpWidgetState();
// }

@immutable
class RatingPopUpWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final RatingController ratingController = RatingController();
  final TextEditingController reviewController = TextEditingController();

  final Store<AppState> store;

  RatingPopUpWidget({
    Key? key,
    required this.onPressed,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: SingleChildScrollView(
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
                  ratingController: ratingController,
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
                    StoreConnector<AppState, _ViewModel>(
                      vm: () => _Factory(this),
                      builder: (BuildContext context, _ViewModel vm) =>
                          ButtonWidget(
                        text: "Submit",
                        function: () {
                          if (reviewController.value.text.trim().isEmpty) {
                            displayToastError(
                                context, "A review requires a description");
                            return;
                          }

                          onPressed();
                          vm.dispatchAddReviewAction(
                            rating: ratingController.rating,
                            description: reviewController.value.text,
                          );
                        },
                      ),
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
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, RatingPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchAddReviewAction: ({
          required String description,
          required int rating,
        }) =>
            dispatch(AddReviewAction(
          description: description,
          rating: rating,
        )),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function({
    required String description,
    required int rating,
  }) dispatchAddReviewAction;

  _ViewModel({
    required this.dispatchAddReviewAction,
  }); // implementinf hashcode
}

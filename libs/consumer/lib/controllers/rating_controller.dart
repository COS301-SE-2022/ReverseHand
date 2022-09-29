import 'package:flutter/material.dart';

class RatingController extends ChangeNotifier {
  int rating = 0;

  void setRating(int rating) {
    this.rating = rating;
    notifyListeners();
  }
}

import 'package:consumer/controllers/rating_controller.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final Color color;
  final RatingController ratingController;

  const StarRating({
    Key? key,
    required this.ratingController,
    required this.color,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int starCount = 5;
  int rating = 0;

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.yellow,
        size: 40,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: Colors.yellow,
        size: 40,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 40,
      );
    }
    return InkResponse(
      onTap: () {
        setState(() {
          if (index == 0 && rating == 1) {
            rating = 0;
          } else {
            rating = index + 1;
          }

          widget.ratingController.setRating(rating);
        });
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}

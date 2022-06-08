import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  const StarRating({
    Key? key, 
    this.starCount = 5, 
    this.rating = .0, 
    required this.onRatingChanged, 
    required this.color
    }): super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.orange,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: Colors.orange,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: Colors.orange,
      );
    }
    return InkResponse(
      // ignore: unnecessary_null_comparison
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}
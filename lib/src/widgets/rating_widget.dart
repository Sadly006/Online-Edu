import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int starCount;
  final double rating;

  const RatingWidget({super.key, this.starCount = 5, required this.rating});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        size: 20,
        color: Colors.black,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: 20,
        color: Theme.of(context).primaryColor,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: 20,
        color: Theme.of(context).primaryColor,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}
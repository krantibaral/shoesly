import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final double rating;

  const StarDisplay({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 15);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 15);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 15);
        }
      }),
    );
  }
}

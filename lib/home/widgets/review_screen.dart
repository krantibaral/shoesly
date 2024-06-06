import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class FullReviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;

  const FullReviewScreen({Key? key, required this.reviews}) : super(key: key);

  @override
  _FullReviewScreenState createState() => _FullReviewScreenState();
}

class _FullReviewScreenState extends State<FullReviewScreen> {
  double _calculateAverageRating() {
    if (widget.reviews.isEmpty) {
      return 0.0;
    }

    double totalRating = 0.0;
    for (var review in widget.reviews) {
      totalRating += review['rating'];
    }
    return totalRating / widget.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(
                  'Reviews (${widget.reviews.length})',
                  style: sMediumText,
                ),
                centerTitle: true,
                actions: [
                  Row(
                    children: [
                      const Icon(Icons.star, color:Colors.amber),
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: sBodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/home/widgets/star_display.dart';

class ReviewListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewListWidget({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> review = reviews[index];

        // Extract review details
        String name = review['name'];
        String comment = review['comment'];
        String rating = review['rating'].toString();
        String timestamp = review['date'].toString();
        String imageUrl = review['image'].toString();

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                imageUrl), // Assuming you have an imageUrl field in the review data
          ),
          title: Text(name, style: sMediumnText,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StarDisplay(rating: double.parse(rating)),
              const SizedBox(height: 3),
              Text(comment, style: sBodyText2, textAlign: TextAlign.justify,),
              // Text('Date: $timestamp'),
            ],
          ),
        );
      },
    );
  }
}
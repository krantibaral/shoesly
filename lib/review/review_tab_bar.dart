import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/widgets/review_list.dart';

class ReviewTabBarPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewTabBarPage({Key? key, required this.reviews}) : super(key: key);

  List<Map<String, dynamic>> _filterReviews(int rating) {
    if (rating == 0) {
      return reviews;
    }
    return reviews.where((review) => review['rating'] == rating).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
        children: [
          const TabBar(
            dividerColor: backgroundColor,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            labelStyle: sMediumTabText,
            unselectedLabelColor: Color(0xffb7b7b7),
            isScrollable: true,
            tabs: [
              Tab(text: 'All'),
              Tab(text: '5 Star'),
              Tab(text: '4 Star'),
              Tab(text: '3 Star'),
              Tab(text: '2 Star'),
              Tab(text: '1 Star'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildReviewList(_filterReviews(0)),
                _buildReviewList(_filterReviews(5)),
                _buildReviewList(_filterReviews(4)),
                _buildReviewList(_filterReviews(3)),
                _buildReviewList(_filterReviews(2)),
                _buildReviewList(_filterReviews(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(List<Map<String, dynamic>> reviews) {
    if (reviews.isEmpty) {
      return const Center(
        child: Text(
          'No data',
          style: sBodyText1,
        ),
      );
    }

    return ReviewListWidget(reviews: reviews); // Use ReviewListWidget
  }
}

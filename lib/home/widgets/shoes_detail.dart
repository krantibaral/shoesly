import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/home/widgets/add_to_cart.dart';
import 'package:shoesly/home/widgets/images_slide.dart';
import 'package:shoesly/home/widgets/review_list.dart';
import 'package:shoesly/home/widgets/review_screen.dart';
import 'package:shoesly/home/widgets/size_selector.dart';
import 'package:shoesly/home/widgets/star_display.dart';

class ShoesDetail extends StatelessWidget {
  const ShoesDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve shoe data from arguments
    final Map<String, dynamic> shoeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Map<String, dynamic> reviewsMap = shoeData['review'];

    Map<String, dynamic> imageMap = shoeData['image'];
    List<String> imageUrls = imageMap.values.map((value) => value.toString()).toList();

    // Convert reviews map to a list and sort by date
    List<Map<String, dynamic>> reviews = reviewsMap.values.map((review) {
      review['key'] = reviewsMap.keys.firstWhere((k) => reviewsMap[k] == review);
      return review;
    }).toList().cast<Map<String, dynamic>>(); // Ensure the list is of the correct type

    reviews.sort((a, b) => b['date'].compareTo(a['date']));
    List<Map<String, dynamic>> latestReviews = reviews.take(2).toList();

    print(imageUrls);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined),
                            onPressed: () {
                              // Add your onPressed functionality here
                            },
                          ),
                        ],
                      ),
                      // Display shoe image
                      ImageCarousel(imageUrls: imageUrls),
                      const SizedBox(height: 5),
                      // Display shoe details
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shoeData['name'],
                              style: sMediumTabText,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                StarDisplay(
                                    rating: double.parse(
                                        shoeData['rating'].toString())),
                                const SizedBox(width: 5),
                                Text(shoeData['rating'].toString(),
                                    style: sBodyText1),
                                const SizedBox(width: 5),
                                Text(
                                  '(${shoeData['review'].length.toString()} review)',
                                  style: sBodyText2,
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              "Size",
                              style: sMediumsText,
                            ),
                            const SizedBox(height: 3),
                            SizeSelector(sizes: shoeData['sizes']),
                            const SizedBox(height: 20),
                            const Text(
                              "Description",
                              style: sMediumsText,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              shoeData['description'],
                              style: sBodyText,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Review (${latestReviews.length})",
                                  style: sMediumsText,
                                ),
                                TextButton(
                                  onPressed: () {
                                     Get.to(FullReviewScreen(reviews: reviews));
                                  },
                                  child: const Text(
                                    'View more',
                                    style: vBodyText1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            ReviewListWidget(reviews: latestReviews),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Static section at the bottom
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Price', style: sBodyText2),
                      Text(
                        '\$${shoeData['price']}',
                        style: sMediumText,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double price =
                          (shoeData['price'] as num).toDouble();
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return AddToCartBottomSheet(price: price);
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'ADD TO CART',
                      style: sWhiteText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoesly/cart/cart_details.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/cart/add_to_cart.dart';
import 'package:shoesly/detail/image_slider.dart';
import 'package:shoesly/review/review_list.dart';
import 'package:shoesly/review/review_screen.dart';
import 'package:shoesly/detail/size_selector.dart';
import 'package:shoesly/detail/star_display.dart';

class ShoesDetail extends StatefulWidget {
  const ShoesDetail({Key? key}) : super(key: key);

  @override
  State<ShoesDetail> createState() => _ShoesDetailState();
}

class _ShoesDetailState extends State<ShoesDetail> {
  String? _selectedSize;
  String? _selectedColor;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Retrieve shoe data from arguments
    final Map<String, dynamic> shoeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Map<String, dynamic> reviewsMap = shoeData['review'];

    // Convert reviews map to a list and sort by date
    List<Map<String, dynamic>> reviews = reviewsMap.values
        .map((review) {
          review['key'] =
              reviewsMap.keys.firstWhere((k) => reviewsMap[k] == review);
          return review;
        })
        .toList()
        .cast<Map<String, dynamic>>(); // Ensure the list is of the correct type

    reviews.sort((a, b) => b['date'].compareTo(a['date']));
    List<Map<String, dynamic>> latestReviews = reviews.take(3).toList();

//Image array to show in page view builder
    List<String> imageUrls =
        (shoeData['images'] as List<dynamic>).cast<String>();

    // Extract the color data from the nested map
    Map<String, String> colorData =
        (shoeData['color'] as Map<dynamic, dynamic>).cast<String, String>();

    // Convert colorData to a list of Color widgets
    List<Widget> colorWidgets = colorData.keys.map((colorKey) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedColor =
                colorData[colorKey]; // Store the selected color value
          });
        },
        child: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColorFromDatabase(colorKey),
            border: Border.all(
              color: _selectedColor == colorData[colorKey]
                  ? greyColor
                  : Colors.transparent, // Change border color when selected
              width: 1.0,
            ),
          ),
          child: _selectedColor ==
                  colorData[colorKey] // Show check icon if color is selected
              ? const Icon(Icons.check, color: Colors.white)
              : null,
        ),
      );
    }).toList();

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartDetailsScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      // Display shoe image
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 315,
                          decoration: BoxDecoration(
                            color: containerBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ImageSlider(
                            imageUrls: imageUrls,
                            currentIndex: _currentPage,
                            onImageSelected: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Display shoe details
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  shoeData['name'],
                                  style: sMediumTabText,
                                ),
                                Row(
                                  children: colorWidgets,
                                ),
                              ],
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
                            // Inside the build method of ShoesDetail widget
                            SizeSelector(
                              sizes: shoeData['sizes'],
                              onSizeSelected: (String? selectedSize) {
                                setState(() {
                                  _selectedSize = selectedSize;
                                });
                              },
                            ),
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
                                  "Review (${reviews.length})",
                                  style: sMediumsText,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullReviewScreen(
                                          reviews: reviews,
                                        ),
                                      ),
                                    );
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
                      // Check if selected size is null
                      if (_selectedSize == null) {
                        // Show a SnackBar if the size is not selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a size first'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Convert the price to double
                        double price = (shoeData['price'] as num).toDouble();

                        // Show the bottom sheet if the size is selected
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AddToCartBottomSheet(
                              name: shoeData['name'],
                              type: shoeData['type'],
                              selectedSize:
                                  _selectedSize!, // Pass the selected size here
                              image: imageUrls[_currentPage],
                              price: price,
                              color: _selectedColor!,
                            );
                          },
                        );
                      }
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

  Color getColorFromDatabase(String colorKey) {
    final colorMap = {
      'black': Colors.black,
      'red': Colors.red,
      'blue': Colors.blue,
      'white': Colors.white,
      'green': Colors.green,
      // Add other colors as needed
    };

    return colorMap[colorKey] ??
        Colors.transparent; // Default to transparent if color not found
  }
}

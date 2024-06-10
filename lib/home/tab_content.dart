import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_routes.dart';

class TabContent extends StatelessWidget {
  final String type;

  const TabContent({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getDataStream() {
      if (type == 'All') {
        return firestore.collection('Shoes').snapshots().map(
              (querySnapshot) => querySnapshot.docs.toList(),
            );
      } else {
        return firestore
            .collection('Shoes')
            .where('type', isEqualTo: type)
            .snapshots()
            .map(
              (querySnapshot) => querySnapshot.docs.toList(),
            );
      }
    }

    return StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
      stream: getDataStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot<Map<String, dynamic>>> documents =
            snapshot.data ?? [];
        return Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              childAspectRatio: 0.7, // Aspect ratio for each item
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
            ),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var data = documents[index].data();
              if (data == null) {
                return const ListTile(
                  title: Text('No data available'),
                );
              }

              String name = data['name'] ?? 'No name';
              String price =
                  data['price'] != null ? data['price'].toString() : 'No price';
              String imageUrl = data['images'][0] ?? '';
              Map<String, dynamic>? reviewMap =
                  data['review'] as Map<String, dynamic>?;
              String totalRating; //calculate average rating from the review map
              String reviewsCount;

              if (reviewMap != null && reviewMap.isNotEmpty) {
                List<dynamic> reviews = reviewMap.values.toList();
                reviewsCount = reviews.length.toString();

                double averageRating = reviews.map((review) {
                      if (review is Map<String, dynamic>) {
                        return review['rating'] ?? 0.0;
                      }
                      return 0.0;
                    }).reduce((a, b) => a + b) /
                    reviews.length;
                totalRating = averageRating.toStringAsFixed(1);

                // Update the totalRating in Firestore
                firestore
                    .collection('Shoes')
                    .doc(documents[index].id)
                    .update({'totalRating': totalRating});
              } else {
                totalRating = "No rating";
                reviewsCount = "0";
              }

              return GestureDetector(
                onTap: () {
                  print('hekloo');
                  // Ensure that required data is not null
                  if (data['name'] != null &&
                      data['images'] != null &&
                      data['price'] != null &&
                      data['review'] != null &&
                      data['sizes'] != null &&
                      data['type'] != null &&
                      data['description'] != null) {
                    // Navigate to shoes detail page with arguments when tapped
                    Navigator.pushNamed(
                      context,
                      AppRoutes.shoesDetail,
                      arguments: {
                        // Pass only the required data
                        'name': data['name'],
                        'type': data['type'],
                        'price': data['price'],
                        'totalRating': totalRating,
                        'review': data['review'],
                        'sizes': data['sizes'],
                        'color': data['color'],
                        'description': data['description'],
                        'images': data['images'],
                      },
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: containerBackground, // Background color
                        borderRadius:
                            BorderRadius.circular(15), // Circular border radius
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: imageUrl.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                  imageUrl,
                                ),
                            )
                            : const Icon(Icons.image_not_supported, size: 150),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(name, style: sBodyText),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 5),
                        Text(totalRating, style: sBodyText1),
                        const SizedBox(width: 5),
                        Text('($reviewsCount review)', style: sBodyText2),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text('\$$price', style: sMediumText),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

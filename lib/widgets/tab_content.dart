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
              String imageUrl = data['image'] ?? '';
              String rating = data['rating'] != null
                  ? data['rating'].toString()
                  : "No rating";
              String reviews = data['review'] != null
                  ? data['review'].length.toString()
                  : "No reviews";

              return GestureDetector(
                onTap: () {
                  // Ensure that required data is not null
                  if (data['name'] != null &&
                      data['image'] != null &&
                      data['price'] != null &&
                      data['rating'] != null &&
                      data['review'] != null &&
                      data['sizes'] != null &&
                      data['type'] != null &&
                      data['description'] != null) {
                    // Navigate to shoes detail page with arguments when tapped
                    Navigator.pushNamed(
                      context,
                      AppRoutes.shoesDetail,
                      arguments: {
                        'name': data['name'],
                        'image': data['image'],
                        'type': data['type'],
                        'price': data['price'],
                        'rating': data['rating'],
                        'review': data['review'],
                        'sizes': data['sizes'],
                        'description': data['description'],
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
                            ? Image.network(
                                imageUrl,
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
                        Text(rating, style: sBodyText1),
                        const SizedBox(width: 5),
                        Text('($reviews review)', style: sBodyText2),
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

import 'package:flutter/material.dart';

class ShoesDetail extends StatelessWidget {
  const ShoesDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve shoe data from arguments
    final Map<String, dynamic> shoeData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(shoeData['name']), // Display shoe name as the app bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display shoe image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(shoeData['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Display shoe details
            Text('Price: \$${shoeData['price']}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Rating: ${shoeData['rating']}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Reviews: ${shoeData['reviews']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

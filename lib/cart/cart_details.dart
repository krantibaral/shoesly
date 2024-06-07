import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No items in the cart.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name']),
                subtitle: Text(
                    'Price: \$${data['price']}, Quantity: ${data['quantity']}, Size: ${data['size']}'),
                // Add more details as needed
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

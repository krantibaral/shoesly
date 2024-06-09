import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/cart/cart_item_details.dart';
import 'package:shoesly/cart/order_detail_screen.dart';
import 'package:shoesly/constants.dart';

class CartDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              centerTitle: true,
              title: const Text(
                'Cart',
                style: appBarText,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Cart')
                    .snapshots(), //fetching data from the cart collection
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No items in the cart.'),
                    );
                  }

                  var cartItems = snapshot.data!.docs;
                  double totalPrice = 0.0;
                  for (var item in cartItems) {
                    totalPrice +=
                        item['totalPrice']; // calculating the grand total price
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: CartItemListWidget(cartItems: cartItems),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Total Price', style: sBodyText2),
                                  Text('\$${totalPrice.toStringAsFixed(2)}',
                                      style: sMediumText),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderSummaryPage(
                                        totalPrice: totalPrice,
                                        cartItems: cartItems,
                                      ),
                                    ),
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
                                  'CHECKOUT',
                                  style: sWhiteText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

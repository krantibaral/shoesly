import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'package:shoesly/cart/cart_details.dart';
import 'package:shoesly/constants.dart';


class AddToCartBottomSheet extends StatefulWidget {
  final double price;
  final String name;
  final String type;
  final String selectedSize;
  final String image;
  final String color;

  const AddToCartBottomSheet({
    super.key,
    required this.price,
    required this.name,
    required this.type,
    required this.image,
    required this.color,
    required this.selectedSize,
  });

  @override
  _AddToCartBottomSheetState createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * widget.price;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add to cart',
                style: sLargeText,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();

                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Quantity",
              style: sMediumsText,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: primaryColor,
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Total Price',
                    style: sBodyText2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: sMediumText,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Call addToCart function when button is pressed
                  addToCart(totalPrice); // Pass totalPrice here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text('ADD TO CART', style: sWhiteText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to add data to Firestore
  void addToCart(double totalPrice) {
    FirebaseFirestore.instance.collection('Cart').add({
      'name': widget.name,
      'size': widget.selectedSize,
      'quantity': quantity,
      'type': widget.type,
      'color': widget.color,
      'price':widget.price,
      'totalPrice': totalPrice,
      'image': widget.image,
    }).then((value) {
      // Data added successfully
      print('Item added to cart!');
      Navigator.of(context).pop();

      // Close the bottom sheet
      _showAddedToCartBottomSheet(); // Show the "Added to Cart" bottom sheet
    }).catchError((error) {
      // Error occurred
      print('Failed to add item to cart: $error');
      // Handle error appropriately, e.g., show an error message
    });
  }

  // Function to show "Added to Cart" bottom sheet
  void _showAddedToCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle,
                size: 70,
                color: greyColor,
              ),
              const SizedBox(height: 10),
              const Text(
                'Added to Cart',
                style: mLargeText,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Back to Explore button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: primaryColor,
                      backgroundColor: backgroundColor,
                      side: const BorderSide(
                          color: greyColor), 
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                    },
                    child: const Text('BACK EXPLORE',
                        style: TextStyle(fontSize: 14)),
                  ),
                  // Go to Cart button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartDetailsScreen()),
                      );
                    },
                    child: const Text(
                      'GO TO CART',
                      style: sWhiteText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

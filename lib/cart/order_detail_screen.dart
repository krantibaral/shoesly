import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_pages.dart';
import 'package:shoesly/routes/app_routes.dart';

class OrderSummaryPage extends StatelessWidget {
  final double totalPrice;
  final List<QueryDocumentSnapshot> cartItems;

  const OrderSummaryPage({
    Key? key,
    required this.totalPrice,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double shipping = calculateShipping(totalPrice);
    double totalAmount = calculateTotalOrder(totalPrice, shipping);

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
                        title: const Text("Order Summary", style: appBarText),
                      ),
                      const SizedBox(height: 20),
                      const Text("Information", style: sMediumsText),
                      const SizedBox(height: 30),
                      _buildInformationRow("Payment method", "Credit Card"),
                      const SizedBox(height: 8),
                      const Divider(color: Color.fromARGB(255, 226, 226, 226)),
                      const SizedBox(height: 8),
                      _buildInformationRow("Location", "Pokhara Nepal"),
                      const SizedBox(height: 30),
                      const Text("Order Details", style: sMediumsText),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          var item = cartItems[index];
                          return ListTile(
                            title: Text(
                              item['name'],
                              style: sBodyText1,
                            ),
                            subtitle: Text(
                              '${item['type']} . ${item['size']} . Qty ${item['quantity']}',
                              style: const TextStyle(color: greyColor),
                            ),
                            trailing: Text(
                              '\$${item['price']}',
                              style: sMediumnText,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text("Payment Details", style: sMediumsText),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Sub Total", style: greyColorText),
                              Text('\$${totalPrice.toStringAsFixed(2)}',
                                  style: sBodyText1),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Shipping", style: greyColorText),
                              Text('\$${shipping.toStringAsFixed(2)}',
                                  style: sBodyText1),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                              color: Color.fromARGB(255, 226, 226, 226)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Order", style: greyColorText),
                              Text('\$${totalAmount.toStringAsFixed(2)}',
                                  style: sBodyText1),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                        Text('\$${totalAmount.toStringAsFixed(2)}',
                            style: sMediumText),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Add payment details to Firebase collection
                          await FirebaseFirestore.instance
                              .collection('Payment')
                              .add({
                            'totalAmount': totalAmount,
                            'location': 'Pokhara',
                            'paymentMethod': 'Cash on delivery',
                            'timestamp': FieldValue.serverTimestamp(),
                            'cartItems':
                                cartItems.map((item) => item.data()).toList(),
                          });
                          // Remove cart details after payment is successful
                          for (var item in cartItems) {
                            await item.reference.delete();
                          }

                          // Show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Payment Successful'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Redirect to home screen
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homePage,
                          );
                        } catch (e) {
                          // Show error snackbar if payment fails
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Payment Failed: $e'),
                              backgroundColor: Colors.red,
                            ),
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
                        'PAYMENT',
                        style: sWhiteText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: sBodyText1),
            const SizedBox(height: 10),
            Text(value, style: vBodyText1),
          ],
        ),
        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ],
    );
  }

  double calculateShipping(double totalPrice) {
    return 20.0; // added constant value for the shipping is 20
  }

  double calculateTotalOrder(double totalPrice, double shipping) {
    return totalPrice + shipping;
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/constants.dart';

class CartItemListWidget extends StatefulWidget {
  final List<DocumentSnapshot> cartItems;

  const CartItemListWidget({Key? key, required this.cartItems})
      : super(key: key);

  @override
  State<CartItemListWidget> createState() => _CartItemListWidgetState();
}

class _CartItemListWidgetState extends State<CartItemListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.cartItems.isEmpty) {
      return const Center(
        child: Text('No items in the cart.'),
      );
    }

    // Sort cartItems in reverse order to show the latest items first
    List<DocumentSnapshot> sortedCartItems =
        List.from(widget.cartItems);

    return ListView.builder(
      itemCount: sortedCartItems.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> data =
            sortedCartItems[index].data() as Map<String, dynamic>;

        return Dismissible(
          // swipe widget to remove data from list
          key: Key(sortedCartItems[index].id),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
                color: const Color(0xffff4c5e),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (direction) async {
            try {
              await FirebaseFirestore.instance
                  .collection('Cart')
                  .doc(sortedCartItems[index].id)
                  .delete();

              setState(() {
                // Remove the item from both original and sorted lists
                widget.cartItems.remove(sortedCartItems[index]);
                sortedCartItems.removeAt(index);
              });
            } catch (error) {
              if (mounted) {
                //to check if widget is still part of the widget tree
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete item: $error')),
                );
              }
            }
          },
          child: Card(
            color: backgroundColor,
            elevation: 0,
            // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Image
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: containerBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      data['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Item Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['name'], style: sMediumsText),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text('${data['type']}', style: vBodyText1),
                            const SizedBox(width: 3),
                            const Text('.', style: vBodyText1),
                            const SizedBox(width: 3),
                              Text('${data['color']}', style: vBodyText1),
                               const Text('.', style: vBodyText1),
                            const SizedBox(width: 3),
                            Text('${data['size']}', style: vBodyText1),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${data['price']}', style: sMediumText),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline,
                                      color: greyColor),
                                  onPressed: () async {
                                    int? quantity = data['quantity'];
                                    if (quantity != null && quantity > 0) {
                                      await FirebaseFirestore.instance
                                          .collection('Cart')
                                          .doc(sortedCartItems[index].id)
                                          .update({'quantity': quantity - 1});

                                      // calculate total price and update in Firestore
                                      await updateTotalPrice(
                                          sortedCartItems[index].id,
                                          data['price'],
                                          quantity - 1);
                                    }
                                  },
                                ),
                                Text(data['quantity'].toString(),
                                    style: const TextStyle(fontSize: 16.0)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () async {
                                    int? quantity = data['quantity'];
                                    if (quantity != null) {
                                      await FirebaseFirestore.instance
                                          .collection('Cart')
                                          .doc(sortedCartItems[index].id)
                                          .update({'quantity': quantity + 1});

                                      // calculate total price and update in Firestore
                                      await updateTotalPrice(
                                          sortedCartItems[index].id,
                                          data['price'],
                                          quantity + 1);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // method calculates the total price and store the data in the database
  Future<void> updateTotalPrice(
      String docId, double unitPrice, int quantity) async {
    double totalPrice = unitPrice * quantity;

    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(docId)
        .update({'totalPrice': totalPrice});
  }
}

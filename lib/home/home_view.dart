import 'package:flutter/material.dart';
import 'package:shoesly/cart/cart_details.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/filter/filter_screen.dart';
import 'package:shoesly/routes/app_routes.dart';
import 'package:shoesly/home/tab_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<String>> getShoeTypesStream() {
    return _firestore.collection('Shoes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()['type'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Discover',
                    style: sLargeText,
                  ),
                ),
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
              const SizedBox(height: 12.0),
              StreamBuilder<List<String>>(
                stream: getShoeTypesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  var types = snapshot.data ?? [];
                  return Expanded(
                    child: CustomTabBar(types: types),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: primaryColor,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            QuerySnapshot<Map<String, dynamic>> snapshot =
                await _firestore.collection('Shoes').get();
            List<DocumentSnapshot<Map<String, dynamic>>> shoesData =
                snapshot.docs;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterScreen(
                  shoesData: shoesData.map((doc) => doc.data()!).toList(),
                ),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tune, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'FILTER',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

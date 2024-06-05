import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/home/homeController.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      // Add your onPressed functionality here
                    },
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                  stream: controller.getDataStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<DocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(documents[index].id), // Display document ID
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

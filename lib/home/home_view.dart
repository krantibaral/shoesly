import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/home/home_controller.dart';
import 'package:shoesly/widgets/tab_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                      // Add your onPressed functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              FutureBuilder<List<String>>(
                future: controller.getTypes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: primaryColor));
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
          onPressed: () {
            // Add your onPressed functionality here
          },
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove elevation to prevent shadow
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

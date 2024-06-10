import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';
import 'tab_content.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> types;

  const CustomTabBar({Key? key, required this.types}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remove duplicates from the types list
    final List<String> uniqueTypes = types.toSet().toList();
    final List<String> validTypes = [
      'All',
      ...uniqueTypes
    ]; // Include 'All' as the first tab

    return DefaultTabController(
      length: validTypes.length,
      child: Column(
        children: [
          TabBar(
            dividerColor: backgroundColor,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            labelStyle: sMediumTabText,
            unselectedLabelColor: const Color(0xffb7b7b7),
            tabs: validTypes.map((type) => Tab(text: type)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: validTypes.map((type) {
                // Only create TabContent for types that have associated shoes
                if (type == 'All' || types.contains(type)) {
                  return TabContent(type: type);
                } else {
                  return Container();
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';
import 'tab_content.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> types;

  const CustomTabBar({Key? key, required this.types}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allTypes = ['All', ...types]; // Include 'All' as the first tab

    return DefaultTabController(
      length: allTypes.length,
      child: Column(
        children: [
          TabBar(
            dividerColor: backgroundColor,

            isScrollable: true,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            labelStyle: sMediumTabText,
            unselectedLabelColor: const Color(0xffb7b7b7),

            tabs: allTypes.map((type) => Tab(text: type)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: allTypes.map((type) => TabContent(type: type)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class SortBySection extends StatefulWidget {
  final Function(String) onSortSelected;

  const SortBySection({Key? key, required this.onSortSelected})
      : super(key: key);

  @override
  _SortBySectionState createState() => _SortBySectionState();
}

class _SortBySectionState extends State<SortBySection> {
  String? selectedSort;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Sort By", style: sMediumsText),
        const SizedBox(height: 10),
        // Sort buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSortButton("Most Recent", context),
              _buildSortButton("Lowest Price", context),
              _buildSortButton("Highest Price", context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortButton(String label, BuildContext context) {
    final bool isSelected = selectedSort == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedSort = label;
          });
          widget.onSortSelected(label);
        },
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(
              isSelected ? Colors.white : Colors.black),
          backgroundColor: WidgetStateProperty.all<Color>(
              isSelected ? primaryColor : Colors.transparent),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(color: isSelected ? primaryColor : Colors.grey),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

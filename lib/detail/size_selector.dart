import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class SizeSelector extends StatefulWidget {
  final Map<String, dynamic> sizes;
  final Function(String?) onSizeSelected; // Callback function to update selected size

  const SizeSelector({Key? key, required this.sizes, required this.onSizeSelected}) : super(key: key);

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? _selectedSize; // To keep track of the selected size

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0, // Horizontal spacing between buttons
      children: widget.sizes.entries.map((entry) {
        return ChoiceChip(
          checkmarkColor: backgroundColor,
          label: Text(
            entry.value.toString(),
            style: TextStyle(
              color: _selectedSize == entry.key ? backgroundColor : greyColor, // Text color based on selection
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Make the chip circular
            side: const BorderSide(color: containerBackground), // Border color
          ),
          selectedColor: primaryColor, // Set selected color to primaryColor
          backgroundColor: backgroundColor, // Background color for unselected chips
          selected: _selectedSize == entry.key,
          onSelected: (bool selected) {
            setState(() {
              _selectedSize = selected ? entry.key : null;
            });
            // Call the callback function to update selected size in parent widget
            widget.onSizeSelected(_selectedSize);
          },
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class ColorFilter extends StatefulWidget {
  final Map<String, String> availableColors;
  final Function(String) onColorSelected;

  const ColorFilter({
    Key? key,
    required this.availableColors,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _ColorFilterState createState() => _ColorFilterState();
}

class _ColorFilterState extends State<ColorFilter> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Color", style: sMediumsText),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.availableColors.keys
                .map((colorKey) =>
                    _buildColorButton(colorKey, widget.availableColors[colorKey]!, context))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildColorButton(String colorKey, String colorName, BuildContext context) {
    final bool isSelected = selectedColor == colorKey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = colorKey;
          });
          widget.onColorSelected(colorKey);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getColorFromName(colorKey),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                colorName,
                style: TextStyle(
                  color: isSelected ? Colors.white : primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      // Add more colors as needed
      default:
        return Colors.grey; // Fallback color if the name is not recognized
    }
  }
}

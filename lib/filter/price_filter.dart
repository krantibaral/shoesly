import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class PriceRangeFilter extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final RangeValues values;
  final void Function(RangeValues) onRangeChanged;

  const PriceRangeFilter({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.values,
    required this.onRangeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Price Range", style: sMediumsText),
        const SizedBox(height: 10),
        RangeSlider(
          activeColor: primaryColor,
          inactiveColor: const Color.fromARGB(255, 209, 209, 209),
          labels: RangeLabels(
            '\$${values.start}',
            '\$${values.end}',
          ),
          values: values,
          min: minPrice,
          max: maxPrice,
          divisions: ((maxPrice - minPrice) / 10).floor(), // Example division
          onChanged: onRangeChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${minPrice.toStringAsFixed(2)}', style: sBodyText2),
            Text('\$${maxPrice.toStringAsFixed(2)}', style: sBodyText2),
          ],
        ),
      ],
    );
  }
}

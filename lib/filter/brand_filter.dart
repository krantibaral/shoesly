import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class BrandFilter extends StatefulWidget {
  final List<Map<String, dynamic>> shoesData;
  final void Function(Set<String>) onBrandSelected;

  const BrandFilter({
    Key? key,
    required this.shoesData,
    required this.onBrandSelected,
  }) : super(key: key);

  @override
  _BrandFilterState createState() => _BrandFilterState();
}

class _BrandFilterState extends State<BrandFilter> {
  Set<String> selectedBrands = {};
  Set<String> uniqueBrands = {}; // unique brand names

  @override
  void initState() {
    super.initState();
    //  set with unique brand names
    widget.shoesData.forEach((shoe) {
      uniqueBrands.add(shoe['type']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Brands", style: sMediumsText),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: uniqueBrands
                .map((brand) => _buildBrandItem(brand))
                .toList(), // Use unique brands for building UI
          ),
        ),
      ],
    );
  }

  Widget _buildBrandItem(String brand) {
    List<Map<String, dynamic>> brandShoes =
        widget.shoesData.where((shoe) => shoe['type'] == brand).toList();

    bool isSelected = selectedBrands.contains(brand);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrands.clear();
          selectedBrands.add(brand);
          widget.onBrandSelected(selectedBrands);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(
                    brandShoes
                        .first['logo'], // Use the logo URL of the first shoe
                  ),
                ),
                if (isSelected)
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              brand,
              style: sBodyText,
            ),
            Text(
              '${brandShoes.length} item${brandShoes.length != 1 ? 's' : ''}',
              style: vBodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

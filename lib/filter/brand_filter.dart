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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> brands = widget.shoesData
        .map((shoe) => {'type': shoe['type'], 'logo': shoe['logo']})
        .toSet()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Brands", style: sMediumsText),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: brands.map((brand) => _buildBrandItem(brand)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandItem(Map<String, dynamic> brandData) {
    String brand = brandData['type'];
    String logo = brandData['logo'];
    List<Map<String, dynamic>> brandShoes =
        widget.shoesData.where((shoe) => shoe['type'] == brand).toList();

    bool isSelected = selectedBrands.contains(brand);

    return GestureDetector(
      onTap: () {
        setState(() {
          // Clear the selectedBrands set and add the tapped brand
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
                    (logo), 
                  ), // Use the logo URL as background image
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

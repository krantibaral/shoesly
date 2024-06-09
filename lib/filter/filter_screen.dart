import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/filter/brand_filter.dart';
import 'package:shoesly/filter/price_filter.dart';
import 'package:shoesly/filter/sort_by_filter.dart';
import 'package:shoesly/filter/gender_filter.dart';
import 'package:shoesly/filter/color_filter.dart';
import 'package:shoesly/routes/app_routes.dart';

class FilterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> shoesData;

  const FilterScreen({Key? key, required this.shoesData}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Set<String> selectedBrands = {};
  RangeValues _values = const RangeValues(0, 0);
  String selectedSortBy = "";
  String selectedGender = "";
  String selectedColor = "";
  late double minPrice;
  late double maxPrice;
  late Map<String, String> availableColors;
  late Map<String, String> availableGenders;

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    List<double> prices = widget.shoesData
        .map((shoe) => (shoe['price'] as int).toDouble())
        .toList();
    if (prices.isNotEmpty) {
      minPrice =
          prices.reduce((value, element) => value < element ? value : element);
      maxPrice =
          prices.reduce((value, element) => value > element ? value : element);
      _values = RangeValues(minPrice, maxPrice);
    } else {
      minPrice = 0;
      maxPrice = 0;
      _values = const RangeValues(0, 0);
    }

    Map<String, String> colorsMap = {};
    for (var shoe in widget.shoesData) {
      if (shoe.containsKey('color')) {
        Map<String, dynamic> colorData = shoe['color'];
        colorData.forEach((key, value) {
          colorsMap[key] = value.toString();
        });
      }
    }
    availableColors = colorsMap;

    Map<String, String> gendersMap = {};
    for (var shoe in widget.shoesData) {
      if (shoe.containsKey('gender')) {
        Map<String, dynamic> genderData = shoe['gender'];
        genderData.forEach((key, value) {
          gendersMap[key] = value.toString();
        });
      }
    }
    availableGenders = gendersMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        title: const Text("Filter", style: appBarText),
                      ),
                      BrandFilter(
                        shoesData: widget.shoesData,
                        onBrandSelected: (brands) {
                          setState(() {
                            selectedBrands = brands;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      PriceRangeFilter(
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        values: _values,
                        onRangeChanged: (values) {
                          setState(() {
                            _values = values;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      SortBySection(
                        onSortSelected: (sortType) {
                          setState(() {
                            selectedSortBy = sortType;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      GenderFilter(
                        availableGenders: availableGenders,
                        onGenderSelected: (gender) {
                          setState(() {
                            selectedGender = gender;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ColorFilter(
                        availableColors: availableColors,
                        onColorSelected: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            // Static container
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _resetFilters,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: greyColor),
                        backgroundColor: backgroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'RESET',
                        style: sBlackText,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _applyFiltersAndRedirect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'APPLY',
                        style: sWhiteText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      selectedBrands.clear();
      _values = RangeValues(minPrice, maxPrice);
      selectedSortBy = "";
      selectedGender = "";
      selectedColor = "";
    });
  }

  void _applyFiltersAndRedirect() {
    List<Map<String, dynamic>> filteredData = _applyFilters();
    if (filteredData.isNotEmpty) {
      Navigator.pushNamed(
        context,
        AppRoutes.shoesDetail,
        arguments: filteredData.first, // Pass the first filtered item
      );
    } else {
      print("No filtered data found.");
      // Show Snackbar if no filtered data found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No filtered data found.'),
        ),
      );
    }
  }

  List<Map<String, dynamic>> _applyFilters() {
    List<Map<String, dynamic>> filteredData = List.from(widget.shoesData);

    if (selectedBrands.isNotEmpty) {
      filteredData = filteredData.where((shoe) {
        return selectedBrands.contains(shoe['type']);
      }).toList();
    }

    filteredData = filteredData.where((shoe) {
      double price = (shoe['price'] as int).toDouble();
      return price >= _values.start && price <= _values.end;
    }).toList();

    if (selectedSortBy.isNotEmpty) {
      switch (selectedSortBy) {
        case "Most Recent":
          filteredData.sort((a, b) => b['date'].compareTo(a['date']));
          break;
        case "Lowest Price":
          filteredData
              .sort((a, b) => (a['price'] as int).compareTo(b['price']));
          break;
        case "Highest Price":
          filteredData
              .sort((a, b) => (b['price'] as int).compareTo(a['price']));
          break;
      }
    }

    if (selectedGender.isNotEmpty) {
      filteredData = filteredData.where((shoe) {
        return shoe.containsKey('gender') && shoe['gender'] == selectedGender;
      }).toList();
    }

    return filteredData;
  }
}

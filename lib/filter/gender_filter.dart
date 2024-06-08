import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class GenderFilter extends StatefulWidget {
  final Map<String, String> availableGenders;
  final Function(String) onGenderSelected;

  const GenderFilter({
    Key? key,
    required this.availableGenders,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  _GenderFilterState createState() => _GenderFilterState();
}

class _GenderFilterState extends State<GenderFilter> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Gender", style: sMediumsText),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.availableGenders.keys
                .map((genderKey) =>
                    _buildGenderButton(genderKey, widget.availableGenders[genderKey]!, context))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderButton(String genderKey, String genderName, BuildContext context) {
    final bool isSelected = selectedGender == genderKey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = genderKey;
          });
          widget.onGenderSelected(genderKey);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: isSelected ? primaryColor : Colors.grey),
          ),
          child: Text(
            genderName,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

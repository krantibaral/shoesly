import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final int currentIndex; // Initial index for the slider
  final Function(int) onImageSelected;

  const ImageSlider({
    Key? key,
    required this.imageUrls,
    required this.currentIndex,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentIndex; // Set the initial index
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
              widget.onImageSelected(index);
            });
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = index;
                  widget.onImageSelected(index);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: _currentPage == index
                      ? Border.all(
                          color: Color.fromARGB(255, 215, 215, 215),
                          width: 1.0,
                        )
                      : null,
                ),
                child: Image.network(
                  widget.imageUrls[index],
                ),
              ),
            );
          },
          // initialPage: widget.currentIndex, // Set the initial index
        ),
        Positioned(
          bottom: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(widget.imageUrls.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? primaryColor : greyColor,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarouselWidget extends StatelessWidget {
  final List<String> images;

  const ImageCarouselWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 230),
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        final firstImage = images[index];

        return buildImage(firstImage, index, context);
      },
    );
  }

//the actual container for the carousel
  Widget buildImage(String firstImage, int index, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        color: Colors.grey,
        child: Image.network(
          firstImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ));
  }
}

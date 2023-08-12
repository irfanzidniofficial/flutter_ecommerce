import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.bannerImages.map((i) {
        return Builder(
          builder: (context) => Image.network(
            i,
            fit: BoxFit.cover,
            height: 200,
            scale: 1,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 150,
        autoPlay: true,
      ),
    );
  }
}

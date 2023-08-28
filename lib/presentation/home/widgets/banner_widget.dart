import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        items: GlobalVariables.bannerImages.map((i) {
          return Builder(
            builder: (context) => Image.asset(
              i,
              fit: BoxFit.cover,
              width: double.infinity,
              scale: 1,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 222,
          autoPlay: true,
        ),
      ),
    );
  }
}

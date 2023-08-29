import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';
import 'package:flutter_ecommerce/common/theme.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentIndex = 0;

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CarouselSlider(
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
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  viewportFraction: 1,
                  height: 222,
                  autoPlay: true,
                ),
              ),
              Positioned(
                bottom: 10, // Adjust the bottom padding as needed
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: GlobalVariables.bannerImages.map((i) {
                      int index = GlobalVariables.bannerImages.indexOf(i);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 3.0), // Add horizontal spacing
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index ? greyColor : whiteColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

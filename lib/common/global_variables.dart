import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL'];

class GlobalVariables {
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Skincare',
      'image': 'assets/icons/ic_skincare.png',
    },
    {
      'title': 'Jewellery',
      'image': 'assets/icons/ic_jewellery.png',
    },
    {
      'title': 'Handbags',
      'image': 'assets/icons/ic_handbags.png',
    },
    {
      'title': 'Watches',
      'image': 'assets/icons/ic_watches.png',
    },
    {
      'title': 'Clothes',
      'image': 'assets/icons/ic_watches.png',
    },
    {
      'title': 'Watches',
      'image': 'assets/icons/ic_jewellery.png',
    },
    {
      'title': 'Watches',
      'image': 'assets/icons/ic_watches.png',
    },
  ];

  static const List<String> bannerImages = [
    'assets/images/img_banner_promo1.png', 
    'assets/images/img_banner_promo2.png',
  ];

  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color(0xffEE4D2D);
  static const unselectedNavBarColor = Colors.black87;
}

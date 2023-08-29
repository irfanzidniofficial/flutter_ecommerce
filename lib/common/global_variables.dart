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
      'title': 'Parfum',
      'image': 'assets/icons/ic_parfum.png',
    },
    {
      'title': 'Clothes',
      'image': 'assets/icons/ic_clothes.png',
    },
    {
      'title': 'Sneakers',
      'image': 'assets/icons/ic_sneakers.png',
    },
  ];

  static const List<String> bannerImages = [
    'assets/images/img_banner_promo1.png',
    'assets/images/img_banner_promo2.png',
  ];
}

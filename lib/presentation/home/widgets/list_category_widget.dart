import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';
import 'package:flutter_ecommerce/common/theme.dart';

class ListCategoryWidget extends StatelessWidget {
  const ListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lighGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  GlobalVariables.categoryImages[index]['image']!,
                  height: 36,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                GlobalVariables.categoryImages[index]['title']!,
                style:
                    blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              )
            ],
          );
        },
      ),
    );
  }
}

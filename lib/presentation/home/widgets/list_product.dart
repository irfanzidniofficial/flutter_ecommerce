import 'package:flutter/material.dart';

class ListProductWidget extends StatelessWidget {
  const ListProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shadowColor: const Color(0xFFEE4D2D),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'img6.png',
                child: SizedBox(
                  height: 150,
                  child: Image.asset(
                    'assets/images/img6.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Rp. 25.000',
                style: TextStyle(
                  color: Color(0xFFEE4D2D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Apel Fuji',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                height: 1,
                color: Colors.grey[400],
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 18,
                            color: Color(0xffEE4D2D),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Beli",
                            style: TextStyle(
                              color: Color(0xffEE4D2D),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            size: 18,
                            color: Color(0xffEE4D2D),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Text('0'),
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: Color(0xffEE4D2D),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_progress.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "COMING SOON",
              style: pinkTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

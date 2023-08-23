import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Pembayaran Gagal',
        desc: 'Pembayaran Anda Gagal',
        btnOkText: 'Close',
        btnOkColor: Colors.red,
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ));
        },
      ).show();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

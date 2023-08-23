// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/presentation/payment/payment_failed_page.dart';
import 'package:flutter_ecommerce/presentation/payment/payment_success_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWidget extends StatefulWidget {
  const SnapWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<SnapWidget> createState() => _SnapWidgetState();
}

class _SnapWidgetState extends State<SnapWidget> {
  WebViewController? _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://www.youtube.com/"))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url.contains("status_code=200&transaction_status=settlement")) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PaymentSuccessPage();
                },
              ));
            }

            if (url.contains("status_code=202&transaction_status=deny")) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PaymentFailedPage();
                },
              ));
            }

            print("onPageStartted: $url");
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller!),
    );
  }
}

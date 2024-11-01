import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: WebViewWidget(controller: controller..loadRequest(Uri.parse(url))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HookaWebView extends StatefulWidget {
  final String path;
  const HookaWebView({super.key, required this.path});

  @override
  State<HookaWebView> createState() => _HookaWebViewState();
}

class _HookaWebViewState extends State<HookaWebView> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.path)),

          onLoadStop: (_, __) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        if (isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:coallider/features/components/hooka_appbar.dart';
import 'package:coallider/features/components/hooka_close_button.dart';
import 'package:coallider/features/components/hooka_web_view.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hookaAppBar(
        context: context,
        applyLeading: true,
        leading: const HookaCloseButton(),
      ),
      body: SizedBox.expand(
        child: HookaWebView(path: 'https://coallider.ru/privacy'),
      ),
    );
  }
}

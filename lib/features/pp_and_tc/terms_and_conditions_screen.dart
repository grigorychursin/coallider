import 'package:flutter/material.dart';
import 'package:coallider/features/components/app_appbar.dart';
import 'package:coallider/features/components/app_close_button.dart';
import 'package:coallider/features/components/app_web_view.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: thisAppBar(
        context: context,
        applyLeading: true,
        leading: const AppCloseButton(),
      ),
      body: SizedBox.expand(
        child: AppWebView(path: 'https://coallider.ru/oferta'),
      ),
    );
  }
}

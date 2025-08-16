import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_arrow_back.dart';

AppBar thisAppBar({
  required BuildContext context,
  bool applyLeading = true,
  bool applyTitle = true,
  Widget leading = const AppArrowBack(),
}) {
  return AppBar(
    title:
        applyTitle
            ? Text(AppTexts.appName, style: context.textTheme.titleSmall)
            : null,
    leadingWidth: 56.0,
    notificationPredicate: (notification) => false,
    leading: applyLeading ? leading.paddingOnly(left: 16.0) : null,
    automaticallyImplyLeading: applyLeading,
    toolbarHeight:
        Platform.isAndroid
            ? context.mediaQuery.viewPadding.top + 40
            : kToolbarHeight,
    // backgroundColor: Colors.red,
    centerTitle: true,
    elevation: 0.0,
  );
}

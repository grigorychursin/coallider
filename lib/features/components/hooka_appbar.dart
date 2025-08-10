import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hookaapp/core/constants/hooka_texts.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/core/extensions/widget_extension.dart';
import 'package:hookaapp/features/components/hooka_arrow_back.dart';

AppBar hookaAppBar({
  required BuildContext context,
  bool applyLeading = true,
  bool applyTitle = true,
  Widget leading = const HookaArrowBack(),
}) {
  return AppBar(
    title:
        applyTitle
            ? Text(HookaTexts.appName, style: context.textTheme.titleSmall)
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

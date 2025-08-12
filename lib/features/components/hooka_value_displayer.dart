import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coallider/core/constants/hooka_colors.dart';
import 'package:coallider/core/constants/hooka_images.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';

class HookaValueDisplayer extends StatelessWidget {
  final String value;
  final bool inProgress;
  const HookaValueDisplayer({
    super.key,
    required this.value,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.5),
      decoration: BoxDecoration(
        color: context.isLightTheme ? null : HookaColors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
          ).paddingOnly(right: 4.0, left: 3.5),
          SizedBox(
            width: 17.0,
            height: 17.0,
            child:
                inProgress
                    ? CircularProgressIndicator()
                    : SvgPicture.asset(
                      HookaImages.check,
                      color: HookaColors.green,
                      height: 24.0,
                      width: 24.0,
                    ),
          ),
        ],
      ),
    );
  }
}

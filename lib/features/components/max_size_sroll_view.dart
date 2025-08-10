import 'package:flutter/material.dart';

class MaxSizeScrollView extends StatelessWidget {
  final Widget? child;

  MaxSizeScrollView({super.key, this.child});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(child: child),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppTapAnimationHandler extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final Widget child;

  const AppTapAnimationHandler({
    super.key,
    required this.onTap,
    this.onTapUp,
    this.onTapDown,
    required this.child,
  });

  @override
  State<AppTapAnimationHandler> createState() =>
      _AppTapAnimationHandlerState();
}

class _AppTapAnimationHandlerState extends State<AppTapAnimationHandler> {
  double _opacity = 1.0;

  void _onTapDown(TapDownDetails details) {
    if (widget.onTapDown != null) {
      widget.onTapDown!();
    }
    setState(() => _opacity = 0.5);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _opacity = 1.0);
    if (widget.onTapUp != null) {
      widget.onTapUp!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

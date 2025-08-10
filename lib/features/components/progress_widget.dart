import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';

class ProgressWidget<C extends BlocBase<S>, S extends ProgressState>
    extends StatefulWidget {
  final C? bloc;
  final Widget? child;
  final GlobalKey<NavigatorState>? navigatorKey;

  const ProgressWidget({super.key, this.bloc, this.child, this.navigatorKey});

  @override
  ProgressWidgetState<C, S> createState() => ProgressWidgetState();
}

class ProgressWidgetState<C extends BlocBase<S>, S extends ProgressState>
    extends State<ProgressWidget>
    with TickerProviderStateMixin {
  OverlayEntry? progressOverlayEntry;
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: progressOverlayEntry == null,
      child: BlocListener<C, ProgressState>(
        bloc: widget.bloc as C? ?? context.read<C>(),
        listener: (context, state) {
          if (state.inProgress) {
            context.hideKeyboard();
            progressOverlayEntry ??= showProgress();
          } else {
            progressOverlayEntry?.remove();
            progressOverlayEntry = null;
            _animationController.reverse();
          }
        },
        child: widget.child,
      ),
    );
  }

  OverlayEntry showProgress() {
    final entry = OverlayEntry(
      builder:
          (context) => Container(
            alignment: Alignment.center,
            color: const Color(0x80000000),
            child: FadeTransition(
              opacity: animation,
              child: const CircularProgressIndicator(),
            ),
          ),
    );
    widget.navigatorKey == null
        ? Overlay.of(context).insert(entry)
        : widget.navigatorKey!.currentState!.overlay!.insert(entry);
    _animationController.forward();
    return entry;
  }

  @override
  void dispose() {
    progressOverlayEntry?.remove();
    progressOverlayEntry = null;
    _animationController.dispose();
    super.dispose();
  }
}

abstract class ProgressState {
  bool get inProgress;
}

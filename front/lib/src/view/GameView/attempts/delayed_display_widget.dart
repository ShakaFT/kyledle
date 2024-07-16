import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:state_extended/state_extended.dart';

class DelayedDisplayWidget extends StatefulWidget {
  const DelayedDisplayWidget({
    super.key,
    required this.animate,
    required this.child,
    required this.controller,
    required this.delay,
    required this.isFirst,
    required this.isLast,
  });
  final bool animate;
  final Widget child;
  final GameController controller;
  final Duration delay;
  final bool isFirst;
  final bool isLast;

  @override
  DelayedDisplayWidgetState createState() => DelayedDisplayWidgetState();
}

class DelayedDisplayWidgetState extends StateX<DelayedDisplayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween<double>(begin: widget.animate ? 0 : 1, end: 1)
        .animate(_controller);
    if (widget.animate) {
      Future.delayed(widget.delay, () async {
        if (widget.isFirst) {
          widget.controller.setAnimationInProgress();
        }
        await _controller.forward();
        if (widget.isLast) {
          widget.controller.setAnimationInProgress(inProgress: false);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacity,
        child: widget.child,
      );
}

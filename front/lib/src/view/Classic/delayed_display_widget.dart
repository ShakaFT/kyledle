import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';

class DelayedDisplay extends StatefulWidget {
  const DelayedDisplay({
    super.key,
    required this.child,
    required this.controller,
    required this.delay,
    required this.isFirst,
    required this.isLast,
  });
  final Widget child;
  final ClassicController controller;
  final Duration delay;
  final bool isFirst;
  final bool isLast;

  @override
  DelayedDisplayState createState() => DelayedDisplayState();
}

class DelayedDisplayState extends State<DelayedDisplay>
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
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
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

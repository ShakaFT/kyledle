import 'package:flutter/material.dart';

class DelayedDisplay extends StatefulWidget {
  const DelayedDisplay({
    super.key,
    required this.child,
    required this.delay,
    required this.monster,
  });
  final Widget child;
  final Duration delay;
  final String monster;

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
    Future.delayed(widget.delay, () {
      _controller.forward();
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

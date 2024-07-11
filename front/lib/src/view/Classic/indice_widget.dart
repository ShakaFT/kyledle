import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';

class IndiceWidget extends StatefulWidget {
  const IndiceWidget({
    super.key,
    required this.controller,
    required this.indice,
    required this.attemptsRemaining,
  });
  final ClassicController controller;
  final Map<String, dynamic> indice;
  final int attemptsRemaining;

  @override
  IndiceWidgetState createState() => IndiceWidgetState();
}

class IndiceWidgetState extends State<IndiceWidget> {
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MouseRegion(
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: InkWell(
            onTap: _displayIndice,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FaIcon(
                      _getIcon(widget.indice["icon"]),
                      color: widget.attemptsRemaining <= 0
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                  Text(
                    widget.indice["name"],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "Encore ${widget.attemptsRemaining} ${widget.attemptsRemaining > 1 ? 'essais' : 'essai'}",
                    style: TextStyle(
                      color: widget.attemptsRemaining > 0
                          ? Colors.white70
                          : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'crown':
        return FontAwesomeIcons.crown;
      case 'palette':
        return FontAwesomeIcons.palette;
      default:
        return FontAwesomeIcons.question;
    }
  }

  void _onHover(bool isHovered) {
    if (widget.attemptsRemaining > 0) {
      return;
    }
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _displayIndice() {
    if (widget.attemptsRemaining > 0) {
      return;
    }
    widget.controller.updateDisplayedIndice(widget.indice);
  }
}

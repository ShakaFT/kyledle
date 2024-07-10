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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FaIcon(
              _getIcon(widget.indice["icon"]),
              color: widget.attemptsRemaining <= 0 ? Colors.amber : Colors.grey,
            ),
            const Text("Indice"),
            Text(
              "Indice: ${widget.indice["name"]}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
              ),
            ),
            Text(
              "Encore ${widget.attemptsRemaining} essais",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
              ),
            ),
          ],
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
}

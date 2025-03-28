import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/utils.dart';
import 'package:state_extended/state_extended.dart';

class IndiceWidget extends StatefulWidget {
  const IndiceWidget({
    super.key,
    required this.gameController,
    required this.indice,
    required this.attemptsRemaining,
  });
  final GameController gameController;
  final Map<String, dynamic> indice;
  final int attemptsRemaining;

  @override
  IndiceWidgetState createState() => IndiceWidgetState();
}

class IndiceWidgetState extends StateX<IndiceWidget> {
  bool _isHovered = false;

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
                      getIcon(widget.indice["icon"]),
                      color: _indiceAvailable() ? Colors.amber : Colors.grey,
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
                      color: _indiceAvailable() ? Colors.black : Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _displayIndice() {
    if (!_indiceAvailable()) {
      return;
    }
    widget.gameController.updateDisplayedIndice(widget.indice);
  }

  bool _indiceAvailable() =>
      widget.attemptsRemaining <= 0 || widget.gameController.userWin;

  void _onHover(bool isHovered) {
    if (!_indiceAvailable()) {
      return;
    }
    setState(() {
      _isHovered = isHovered;
    });
  }
}

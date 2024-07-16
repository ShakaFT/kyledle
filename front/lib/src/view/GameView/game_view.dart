import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/GameView/attempts/attempts_widget.dart';
import 'package:kyledle/src/view/GameView/indices/indices_widget.dart';
import 'package:kyledle/src/view/GameView/search_widget.dart';
import 'package:kyledle/src/view/GameView/win_container_widget.dart';
import 'package:state_extended/state_extended.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.kyledleController});
  final KyledleController kyledleController;

  @override
  GameViewState createState() => GameViewState();
}

class GameViewState extends StateX<GameView> {
  GameViewState() : super(controller: GameController()) {
    _controller = controller! as GameController;
  }
  late GameController _controller;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IndicesWidget(
            kyledleController: widget.kyledleController,
            gameController: _controller,
            title: "Devine le Monstre d'aujourd'hui !",
            instruction: "Tape n'importe quel monstre pour commencer.",
          ),
          if (!_controller.userWin)
            SearchWidget(
              kyledleController: widget.kyledleController,
              gameController: _controller,
              hintText: "Tape le nom du monstre",
            ),
          const SizedBox(height: 20),
          if (_controller.attempts.isNotEmpty)
            AttemptsWidget(
              key: const ValueKey("AttemptsWidget"),
              controller: _controller,
            ),
          const SizedBox(height: 10),
          if (_controller.userWin)
            WinContainerWidget(
              kyledleController: widget.kyledleController,
              controller: _controller,
            ),
        ],
      );

  @override
  void dispose() {
    _controller.shouldAnimate = false;
    super.dispose();
  }
}

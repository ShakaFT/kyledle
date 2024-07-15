import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/GameView/attempt_widget.dart';
import 'package:kyledle/src/view/GameView/indices_widget.dart';
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
          if (_controller.attempts.isNotEmpty) ...[
            // Display headers once
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _controller.columns
                  .map<Widget>(
                    (key) => Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(4.0),
                      width: 150, // fixed width for each header
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        border: Border.all(width: 3),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            // Display attempts
            Column(
              key: const ValueKey("attempts"),
              children: _controller.attempts
                  .map(
                    (attempt) => Attempt(
                      key: ValueKey(attempt),
                      animate: _controller.shouldAnimate,
                      attempt: attempt,
                      controller: _controller,
                    ),
                  )
                  .toList(),
            ),
          ],
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

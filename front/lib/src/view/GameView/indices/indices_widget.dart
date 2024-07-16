import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/GameView/indices/indice_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:state_extended/state_extended.dart';

class IndicesWidget extends StatefulWidget {
  const IndicesWidget({
    super.key,
    required this.kyledleController,
    required this.gameController,
    required this.title,
    required this.instruction,
  });
  final KyledleController kyledleController;
  final GameController gameController;
  final String title;
  final String instruction;

  @override
  IndicesWidgetState createState() => IndicesWidgetState();
}

class IndicesWidgetState extends StateX<IndicesWidget> {
  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(
          maxWidth: widget.kyledleController.maxWidth(context),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.yellow.shade700, width: 4.0),
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (widget.gameController.attempts.isEmpty)
              Text(
                widget.instruction,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget
                      .gameController
                      .characters[widget.gameController.target]["indices"]
                      .length,
                  (i) => IndiceWidget(
                    gameController: widget.gameController,
                    indice: widget.gameController
                        .characters[widget.gameController.target]["indices"][i],
                    attemptsRemaining:
                        5 * (i + 1) - widget.gameController.attempts.length,
                  ),
                ),
              ),
            if (widget.gameController.characters.isEmpty)
              Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: Colors.yellow.shade700,
                  rightDotColor: Colors.yellow.shade700,
                  size: 50,
                ),
              ),
            if (widget.gameController.displayedIndice.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      widget.gameController.displayedIndice["name"],
                      style: const TextStyle(
                        fontFamily: 'PixelFont',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.gameController.displayedIndice["value"] is List
                          ? widget.gameController.displayedIndice["value"]
                              .join(", ")
                          : widget.gameController.displayedIndice["value"],
                      style: const TextStyle(
                        fontFamily: 'PixelFont',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/src/view/GameView/attempts/attempt_headers.dart';
import 'package:kyledle/src/view/GameView/attempts/attempt_widget.dart';
import 'package:state_extended/state_extended.dart';

class AttemptsWidget extends StatefulWidget {
  const AttemptsWidget({super.key, required this.controller});
  final GameController controller;

  @override
  AttemptsWidgetState createState() => AttemptsWidgetState();
}

class AttemptsWidgetState extends StateX<AttemptsWidget> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            AttemptHeadersWidget(controller: widget.controller),
            const SizedBox(height: 10),
            Column(
              children: widget.controller.attempts
                  .map(
                    (attempt) => AttemptWidget(
                      key: ValueKey(attempt),
                      animate: widget.controller.shouldAnimate,
                      attempt: attempt,
                      controller: widget.controller,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}

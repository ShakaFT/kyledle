import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:state_extended/state_extended.dart';

class AttemptHeadersWidget extends StatefulWidget {
  const AttemptHeadersWidget({super.key, required this.controller});
  final GameController controller;

  @override
  AttemptHeaderState createState() => AttemptHeaderState();
}

class AttemptHeaderState extends StateX<AttemptHeadersWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.controller.columns
            .map<Widget>(
              (key) => Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(4.0),
                height: 60, // fixed height for each header
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
                child: Center(
                  child: Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
      );
}

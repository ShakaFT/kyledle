import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';

class GameModeButton extends StatelessWidget {
  const GameModeButton({
    super.key,
    required this.kyledleController,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  final KyledleController kyledleController;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: kyledleController.maxWidth(context),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

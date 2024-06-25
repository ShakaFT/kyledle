import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.controller});
  final KyledleController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            // background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/background.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title image
                    Image.asset(
                      "assets/title.png",
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Tous les jours, devine un Monstre !",
                      style: GoogleFonts.lobster(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // list of game modes
                    GameModeButton(
                      text: "CLASSIQUE",
                      description: "Des indices à chaque essai",
                      icon: Icons.lightbulb_outline,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class GameModeButton extends StatelessWidget {
  const GameModeButton({
    super.key,
    required this.text,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  final String text;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
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
                    text,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/Classic/classic_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.controller});
  final KyledleController controller;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  Widget? _currentView;
  bool _isHovered = false;

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
              controller: widget.controller.scrollController,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title image
                    MouseRegion(
                      onEnter: (_) => _onHover(true),
                      onExit: (_) => _onHover(false),
                      child: InkWell(
                        onTap: _resetView,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: _isHovered
                              ? MediaQuery.of(context).size.width * 0.25
                              : MediaQuery.of(context).size.width * 0.23,
                          child: Image.asset(
                            "assets/title.png",
                          ),
                        ),
                      ),
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
                    _currentView ?? _buildGameModes(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildGameModes() => Column(
        children: [
          GameModeButton(
            text: "CLASSIQUE",
            description: "Des indices à chaque essai",
            icon: Icons.lightbulb_outline,
            onPressed: () {
              setState(() {
                _currentView =
                    ClassicView(kyledleController: widget.controller);
              });
            },
          ),
        ],
      );

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _resetView() {
    setState(() {
      _currentView = null;
    });
  }
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

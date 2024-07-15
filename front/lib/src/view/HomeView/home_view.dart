import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/GameView/game_view.dart';
import 'package:kyledle/src/view/HomeView/game_button.dart';
import 'package:state_extended/state_extended.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.controller});
  final KyledleController controller;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends StateX<HomeView> {
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
                              ? widget.controller.maxWidth(context)
                              : widget.controller.maxWidth(context) * 0.95,
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
            kyledleController: widget.controller,
            title: "CLASSIQUE",
            description: "Des indices à chaque essai",
            icon: Icons.lightbulb_outline,
            onPressed: () {
              setState(() {
                _currentView = GameView(kyledleController: widget.controller);
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

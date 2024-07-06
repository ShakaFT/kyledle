import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';

class WinContainerWidget extends StatefulWidget {
  const WinContainerWidget({
    super.key,
    required this.kyledleController,
    required this.controller,
  });
  final ClassicController controller;
  final KyledleController kyledleController;

  @override
  WinContainerWidgetState createState() => WinContainerWidgetState();
}

class WinContainerWidgetState extends State<WinContainerWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollController = widget.kyledleController.scrollController;
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color(0xFFFFD700), width: 4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Félicitations !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.controller
                      .characters[widget.controller.target]["columns"]["Photo"],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Vous avez trouvé ${widget.controller.target} en ${widget.controller.attempts.length} tentatives.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

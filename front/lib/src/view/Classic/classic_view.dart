import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/Classic/attempt_widget.dart';
import 'package:kyledle/src/view/Classic/win_container_widget.dart';
import 'package:state_extended/state_extended.dart';

class ClassicView extends StatefulWidget {
  ClassicView({super.key, required this.kyledleController});

  KyledleController kyledleController;

  @override
  State createState() => _ClassicViewState();
}

class _ClassicViewState extends StateX<ClassicView> {
  _ClassicViewState() : super(controller: ClassicController()) {
    _controller = controller! as ClassicController;
  }
  late ClassicController _controller;
  String _hoveredItem = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController textEditingController;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.yellow.shade700, width: 4.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Devine le Monstre d'aujourd'hui !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tape n'importe quel monstre pour commencer.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            if (!_controller.userWin)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Autocomplete<String>(
                        fieldViewBuilder: (
                          context,
                          fieldTextEditingController,
                          fieldFocusNode,
                          onFieldSubmitted,
                        ) {
                          textEditingController = fieldTextEditingController;
                          return TextField(
                            controller: fieldTextEditingController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tape le nom du monstre',
                            ),
                            enabled: !_controller.animationInProgress,
                            focusNode: fieldFocusNode,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return _controller.characters.keys.where(
                            (character) =>
                                character.toLowerCase().startsWith(
                                      textEditingValue.text
                                          .toLowerCase()
                                          .trim(),
                                    ) &&
                                !_controller.attempts.contains(character),
                          );
                        },
                        optionsViewBuilder: (context, onSelected, options) =>
                            Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              constraints: const BoxConstraints(
                                maxHeight: 300.0,
                              ),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                shrinkWrap:
                                    true, // This will make the ListView adapt its height
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return MouseRegion(
                                    onEnter: (event) {
                                      setState(() {
                                        _hoveredItem = option;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        _hoveredItem = "";
                                      });
                                    },
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        textEditingController.clear();
                                        await _controller.addAttempt(option);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 15.0,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          color: _hoveredItem == option
                                              ? Colors.grey.shade300
                                              : Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  _controller.characters[option]
                                                      ["columns"]["Photo"],
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.shouldAnimate = false;
    super.dispose();
  }
}

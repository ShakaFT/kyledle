import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Game/game_controller.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:state_extended/state_extended.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.kyledleController,
    required this.gameController,
    required this.hintText,
  });
  final KyledleController kyledleController;
  final GameController gameController;
  final String hintText;

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends StateX<SearchWidget> {
  String hoveredItem = "";
  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              width: widget.kyledleController.maxWidth(context),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                    ),
                    enabled: !widget.gameController.animationInProgress &&
                        widget.gameController.dataLoaded,
                    focusNode: fieldFocusNode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
                optionsBuilder: _searchCharacter,
                optionsViewBuilder: (context, onSelected, options) => Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      width: widget.kyledleController.maxWidth(context),
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
                            onEnter: (event) => _hoverItem(option),
                            onExit: (event) => _hoverItem(''),
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                textEditingController.clear();
                                await widget.gameController.addAttempt(option);
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
                                  color: hoveredItem == option
                                      ? Colors.grey.shade300
                                      : Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: widget
                                              .gameController.characters[option]
                                          ["columns"]["Photo"],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
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
      );

  void _hoverItem(String item) {
    setState(() {
      hoveredItem = item;
    });
  }

  Iterable<String> _searchCharacter(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return widget.gameController.characters.keys.where((character) {
      final searchText = textEditingValue.text.toLowerCase().trim();

      final words = character.toLowerCase().split(RegExp(r'[\s-]+'));
      final searchTexts = searchText.split(RegExp(r'[\s-]+'));

      if (widget.gameController.attempts.contains(character) ||
          searchText.isEmpty) {
        return false;
      }

      for (final text in searchTexts) {
        var match = false;
        for (final word in words) {
          if (word.startsWith(text)) {
            match = true;
            break;
          }
        }
        if (!match) {
          return false;
        }
      }
      return true;
    });
  }
}

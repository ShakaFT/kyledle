import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';
import 'package:state_extended/state_extended.dart';

class ClassicView extends StatefulWidget {
  const ClassicView({super.key});

  @override
  State createState() => _ClassicViewState();
}

class _ClassicViewState extends StateX<ClassicView> {
  _ClassicViewState() : super(controller: ClassicController()) {
    _controller = controller! as ClassicController;
  }
  late ClassicController _controller;

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredNames = [];
  bool _showFilteredNames = false;
  String _hoveredItem = '';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_filterNames);
    _focusNode.addListener(_onFocusChange);
  }

  void _filterNames() {
    final query = _textEditingController.text.toLowerCase();
    setState(() {
      _filteredNames = _controller.data.keys
          .where((name) => name.toLowerCase().contains(query))
          .toList();
      _showFilteredNames = _filteredNames.isNotEmpty && _focusNode.hasFocus;
    });
  }

  void _onFocusChange() {
    Future.delayed(Duration(milliseconds: _focusNode.hasFocus ? 0 : 100), () {
      setState(() {
        _showFilteredNames = _focusNode.hasFocus && _filteredNames.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const maxHeight = 100; // Define a fixed height for each item

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF241c04),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: const Color(0xFFFFD700), width: 4.0),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              hintText: "Tape le nom du monstre",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blueGrey),
                          onPressed: () {
                            // Logique pour l'envoi
                          },
                        ),
                      ],
                    ),
                  ),
                  if (_showFilteredNames)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredNames.length,
                          itemBuilder: (context, index) => MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                _hoveredItem = _filteredNames[index];
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                _hoveredItem = '';
                              });
                            },
                            child: Container(
                              color: _hoveredItem == _filteredNames[index]
                                  ? Colors.grey[300]
                                  : Colors.transparent,
                              child: ListTile(
                                onTap: () {
                                  _controller.addAttempt(_filteredNames[index]);
                                  _focusNode.unfocus();
                                },
                                title: Text(_filteredNames[index]),
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
                children:
                    _controller.data[_controller.attempts.first]["columns"].keys
                        .map<Widget>(
                          (key) => Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(4.0),
                            width: 150, // fixed width for each header
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
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
                children: _controller.attempts.map((attempt) {
                  final columns = _controller.data[attempt]["columns"];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: columns.keys.map<Widget>((key) {
                      final value = columns[key];
                      String displayValue;
                      if (value is List) {
                        displayValue = value.join(", ");
                      } else {
                        displayValue = value.toString().trim();
                      }
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(4.0),
                        width: 150, // fixed width for each cell
                        height:
                            maxHeight.toDouble(), // fixed height for each cell
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          child: displayValue.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl:
                                      "https://static.wikia.nocookie.net/mogapedia/images/6/6d/MHWI-Alatreon_Icon.png/revision/latest?cb=20200321134438&path-prefix=fr",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 30,
                                  height: 30,
                                )
                              : Text(displayValue, textAlign: TextAlign.center),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController
      ..removeListener(_filterNames)
      ..dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }
}

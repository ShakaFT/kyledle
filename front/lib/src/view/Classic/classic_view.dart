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
  Widget build(BuildContext context) => Center(
        child: Column(
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
                  Row(
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
                  if (_showFilteredNames)
                    Container(
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
                ],
              ),
            ),
            if (_controller.attempts.isNotEmpty)
              Column(
                children: _controller.attempts
                    .map(
                      (item) => Row(
                        children: [Card(child: Text(item))],
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );

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

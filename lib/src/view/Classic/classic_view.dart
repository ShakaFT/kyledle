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
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tape le nom du monstre",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueGrey),
                    onPressed: () {
                      print("gooo");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

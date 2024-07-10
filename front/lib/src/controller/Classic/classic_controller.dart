import 'dart:async';

import 'package:kyledle/src/model/Classic/classic_network.dart';
import 'package:kyledle/src/shared_preferences/attemps.dart';
import 'package:state_extended/state_extended.dart';

class ClassicController extends StateXController {
  factory ClassicController() => _this ??= ClassicController._();
  ClassicController._() : super();

  static ClassicController? _this;
  bool animationInProgress = false;
  List<String> attempts = [];
  List<dynamic> columns = [];
  List<dynamic> indices = [];
  Map<String, dynamic> characters = {};
  bool shouldAnimate = false;
  String target = "";
  bool userWin = false;

  @override
  Future<void> initState() async {
    await _loadData();
    super.initState();
  }

  addAttempt(String attempt) async {
    if (!characters.containsKey(attempt.trim()) || attempts.contains(attempt)) {
      return;
    }

    setState(() {
      shouldAnimate = true;
      attempts.insert(0, attempt);
    });
    await setAttempts("mhdle", "classic", attempts);
  }

  setAnimationInProgress({bool inProgress = true}) {
    setState(() {
      animationInProgress = inProgress;
      if (!animationInProgress) {
        userWin = attempts[0] == target;
      }
    });
  }

  Future<void> _loadData() async {
    final data = (await getData("mhdle"))!;
    final classicData = data["data"];
    target = data["target"];

    columns = classicData["columns"];
    characters = classicData["characters"];
    indices = classicData["indices"];

    attempts = await getAttempts("mhdle", "classic");
    userWin = (attempts.isEmpty ? "" : attempts[0]) == target;
    setState(() {});
  }
}

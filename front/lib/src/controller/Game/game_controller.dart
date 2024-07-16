import 'dart:async';

import 'package:kyledle/src/model/Classic/classic_network.dart';
import 'package:kyledle/src/shared_preferences/attemps.dart';
import 'package:state_extended/state_extended.dart';

class GameController extends StateXController {
  factory GameController() => _this ??= GameController._();
  GameController._() : super();

  static GameController? _this;
  bool animationInProgress = false;
  List<String> attempts = [];
  List<dynamic> columns = [];
  Map<String, dynamic> characters = {};
  bool dataLoaded = false;
  Map displayedIndice = {};
  bool shouldAnimate = false;
  String target = "";
  bool userWin = false;

  @override
  Future<void> initState() async {
    await _loadData();
    super.initState();
  }

  Future<void> addAttempt(String attempt) async {
    if (!characters.containsKey(attempt.trim()) || attempts.contains(attempt)) {
      return;
    }

    setState(() {
      shouldAnimate = true;
      attempts.insert(0, attempt);
    });
    await setAttempts("mhdle", "classic", attempts);
  }

  void setAnimationInProgress({bool inProgress = true}) {
    setState(() {
      animationInProgress = inProgress;
      if (!animationInProgress) {
        userWin = attempts[0] == target;
      }
    });
  }

  void updateDisplayedIndice(Map indice) {
    final newIndice = displayedIndice == indice ? {} : indice;
    setState(() {
      displayedIndice = newIndice;
    });
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    final data = (await getData("mhdle"))!;
    final classicData = data["data"];
    target = data["target"];

    columns = classicData["columns"];
    characters = classicData["characters"];

    attempts = await getAttempts("mhdle", "classic");
    userWin = (attempts.isEmpty ? "" : attempts[0]) == target;
    dataLoaded = true;
    setState(() {});
  }
}

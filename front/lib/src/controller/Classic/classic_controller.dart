import 'dart:math';
import 'package:kyledle/src/model/Classic/classic_network.dart';
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
  String target = "";
  bool userWin = false;

  @override
  Future<void> initState() async {
    super.initState();
    await _loadData();
  }

  addAttempt(String attempt) {
    if (!characters.containsKey(attempt.trim()) || attempts.contains(attempt)) {
      return;
    }

    setState(() {
      attempts.insert(0, attempt);
    });
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

    target = characters.keys.elementAt(Random().nextInt(characters.length));
    print(target);

    setState(() {});
  }
}

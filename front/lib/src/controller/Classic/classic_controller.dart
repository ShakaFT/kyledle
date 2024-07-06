import 'dart:math';
import 'package:kyledle/src/model/Classic/classic_network.dart';
import 'package:state_extended/state_extended.dart';

class ClassicController extends StateXController {
  factory ClassicController() => _this ??= ClassicController._();
  ClassicController._() : super();

  static ClassicController? _this;
  final List<int> animatedKeys = [];
  List<String> attempts = [];
  List<dynamic> columns = [];
  Map<String, dynamic> monsters = {};
  String searchedMonster = "";

  @override
  Future<void> initState() async {
    super.initState();
    await _loadData();
  }

  addAttempt(String attempt) {
    if (!monsters.containsKey(attempt.trim()) || attempts.contains(attempt)) {
      return;
    }

    setState(() {
      attempts.insert(0, attempt);
    });
  }

  Future<void> _loadData() async {
    final data = (await getData("mhdle"))!;
    columns = data["columns"];
    monsters = data["monsters"];
    searchedMonster =
        monsters.keys.elementAt(Random().nextInt(monsters.length));
    print(searchedMonster);
    setState(() {});
  }
}

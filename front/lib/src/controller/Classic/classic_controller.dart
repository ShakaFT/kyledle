import 'dart:math';
import 'package:kyledle/src/model/Classic/classic_network.dart';
import 'package:state_extended/state_extended.dart';

class ClassicController extends StateXController {
  factory ClassicController() => _this ??= ClassicController._();
  ClassicController._() : super();

  static ClassicController? _this;
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
    setState(() {
      attempts.add(attempt);
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

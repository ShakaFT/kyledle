import 'package:kyledle/src/model/Classic/classic_network.dart';
import 'package:state_extended/state_extended.dart';

class ClassicController extends StateXController {
  factory ClassicController() => _this ??= ClassicController._();
  ClassicController._() : super();

  static ClassicController? _this;
  Map<String, dynamic> data = {};

  @override
  Future<void> initState() async {
    super.initState();
    await _loadData();
  }

  Future<void> _loadData() async {
    data = (await getData("mhdle"))!;
    setState(() {});
  }
}

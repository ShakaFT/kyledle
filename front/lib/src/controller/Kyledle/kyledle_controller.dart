import 'package:flutter/material.dart';
import 'package:state_extended/state_extended.dart';

class KyledleController extends StateXController {
  factory KyledleController() => _this ??= KyledleController._();
  KyledleController._() : super();

  static KyledleController? _this;
  final ScrollController scrollController = ScrollController();

  Future<void> initialize() async {}
}

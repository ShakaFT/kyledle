import 'package:flutter/material.dart';
import 'package:state_extended/state_extended.dart';

class KyledleController extends StateXController {
  factory KyledleController() => _this ??= KyledleController._();
  KyledleController._() : super();

  static KyledleController? _this;
  final ScrollController scrollController = ScrollController();

  Future<void> initialize() async {}

  double maxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const minFactor = 0.95;
    const maxFactor = 0.3;
    const minWidth = 600;
    const maxWidth = 1000;

    var factor = minFactor -
        (minFactor - maxFactor) *
            ((screenWidth - minWidth) / (maxWidth - minWidth));

    if (screenWidth <= minWidth) {
      factor = minFactor;
    } else if (screenWidth >= maxWidth) {
      factor = maxFactor;
    }

    return screenWidth * factor;
  }
}

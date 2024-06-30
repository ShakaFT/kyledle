import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kyledle/src/controller/Kyledle/kyledle_controller.dart';
import 'package:kyledle/src/view/home_view.dart';
import 'package:state_extended/state_extended.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final controller = KyledleController();
  await controller.initialize();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr')],
      title: 'Kyledle',
      home: Kyledle(controller: controller),
    ),
  );
}

class Kyledle extends StatefulWidget {
  const Kyledle({super.key, required this.controller});
  final KyledleController controller;

  @override
  State createState() => _KyledleState();
}

class _KyledleState extends AppStateX<Kyledle> {
  factory _KyledleState() => _this ??= _KyledleState._();
  _KyledleState._() : super();
  static _KyledleState? _this;

  late KyledleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget buildIn(BuildContext context) => HomeView(controller: _controller);
}

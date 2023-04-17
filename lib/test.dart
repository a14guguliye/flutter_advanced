import "package:complete_advanced_flutter/app/app.dart";
import "package:flutter/material.dart";

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState() {
    MyApp.instance.appState = 10;
  }

  void getAppState() {
    debugPrint(MyApp.instance.appState.toString());
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

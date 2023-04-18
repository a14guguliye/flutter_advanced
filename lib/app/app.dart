import "package:complete_advanced_flutter/presentation/resources/routes_manager.dart";
import "package:complete_advanced_flutter/presentation/resources/theme_manager.dart";
import "package:flutter/material.dart";

class MyApp extends StatefulWidget {
  static MyApp instance = MyApp._internal();

  MyApp._internal();

  int appState = 0;

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}

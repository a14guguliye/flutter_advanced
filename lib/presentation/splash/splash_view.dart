import "dart:async";

import "package:complete_advanced_flutter/presentation/resources/color_manager.dart";
import "package:flutter/material.dart";

import "../resources/assets_manager.dart";
import "../resources/routes_manager.dart";

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          Center(child: const Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}

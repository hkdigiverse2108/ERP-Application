import 'package:ai_setu/core/constants/images.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.splashBg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(child: Image.asset(AppLogo.lightAisetuLogo)),
        ],
      ),
    );
  }
}

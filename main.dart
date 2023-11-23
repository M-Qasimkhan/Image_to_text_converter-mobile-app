import 'package:flutter/material.dart';
import 'package:image/Converted.dart';
import 'package:image/image_text.dart';
import 'package:image/translation.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
    home: const SplashScreen(),
    routes: {
      'image_text': (context) => const Image_to_text(),
      'translation': (context) => const TranslationOfText(),
      'Converted': (context) => const ConvertedText(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: LottieBuilder.asset('assets/loading.json'),
        splashIconSize: double.infinity,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
        animationDuration: const Duration(milliseconds: 5),
        nextScreen: const Image_to_text());
  }
}

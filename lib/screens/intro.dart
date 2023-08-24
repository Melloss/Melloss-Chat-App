import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/uiController.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final uiController = Get.put(UIController());

  @override
  void initState() {
    uiController.initSettings();
    Timer(const Duration(seconds: 6), () {
      if (uiController.isLoggedBefore.value == true) {
        Get.offNamed('/chat');
      } else {
        Get.offNamed('/welcome');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    uiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Center(
            child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 13, 66, 107),
                  fontWeight: FontWeight.w500,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      "Melloss Chat",
                      speed: const Duration(milliseconds: 170),
                    ),
                  ],
                )),
          ),
          Expanded(child: Container()),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Developed By Melloss",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

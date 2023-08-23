import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './welcome.dart';
import '../controller/uiController.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

import 'chat.dart';

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
        Get.to(() => const Chat());
      } else {
        Get.to(() => const Welcome());
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

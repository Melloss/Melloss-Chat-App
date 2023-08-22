import 'package:flutter/material.dart';
import 'dart:async' show Timer;

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween(
      begin: 0.0,
      end: 7.99,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.bounceIn,
    ));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.stop();
        Timer(const Duration(seconds: 3), () {
          controller.forward();
        });
      }
    });
    // animation = ColorTween(
    //   begin: Colors.red,
    //   end: Colors.white,
    // ).animate(controller);
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Melloss".substring(0, animation.value.toInt()),
          textScaleFactor: 4,
        ),
      ),
    );
  }
}

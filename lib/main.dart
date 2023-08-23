import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/intro.dart';
import './controller/uiController.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

final uiController = Get.put(UIController());

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Intro(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.black54),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      )),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

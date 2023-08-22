import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/welcome.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Welcome(),
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
  runApp(const App());
}

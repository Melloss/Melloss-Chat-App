import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:melloss_chat_app/screens/chat.dart';
import 'package:melloss_chat_app/screens/register.dart';
import './screens/intro.dart';
import './controller/uiController.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import './screens/welcome.dart';
import './screens/about.dart';

final uiController = Get.put(UIController());

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Intro()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/welcome', page: () => const Welcome()),
        GetPage(name: '/chat', page: () => const Chat()),
        GetPage(name: '/about', page: () => const About()),
      ],
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
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

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDPykDLTcDfCOBgPHrX0hJKUQq7qhSxz78',
    appId: '1:466382242920:web:70427e026176a3b3ee67dd',
    messagingSenderId: '466382242920',
    projectId: 'melloss-chat-ef44f',
    authDomain: 'melloss-chat-ef44f.firebaseapp.com',
    storageBucket: 'melloss-chat-ef44f.appspot.com',
    measurementId: 'G-BFSDRC4VF3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMdKGPHgk5590D16TlRwKtIqN6CkuByvc',
    appId: '1:466382242920:android:e5708e3b6da5df67ee67dd',
    messagingSenderId: '466382242920',
    projectId: 'melloss-chat-ef44f',
    storageBucket: 'melloss-chat-ef44f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1B_R037DbMSFVo4A3ukkeKuDJcllHuYQ',
    appId: '1:466382242920:ios:3efce570ac63b14fee67dd',
    messagingSenderId: '466382242920',
    projectId: 'melloss-chat-ef44f',
    storageBucket: 'melloss-chat-ef44f.appspot.com',
    iosClientId: '466382242920-1uhr70jchdf98ecjshs9o9prpqftq07u.apps.googleusercontent.com',
    iosBundleId: 'com.example.mellossChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1B_R037DbMSFVo4A3ukkeKuDJcllHuYQ',
    appId: '1:466382242920:ios:3efce570ac63b14fee67dd',
    messagingSenderId: '466382242920',
    projectId: 'melloss-chat-ef44f',
    storageBucket: 'melloss-chat-ef44f.appspot.com',
    iosClientId: '466382242920-1uhr70jchdf98ecjshs9o9prpqftq07u.apps.googleusercontent.com',
    iosBundleId: 'com.example.mellossChatApp',
  );
}
